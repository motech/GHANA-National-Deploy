#!/bin/sh

# MySQL Slave machine configuration

. ./replicator.sh

echo "Modifying/Inserting required properties"
cp /etc/my.cnf /tmp/my.cnf
findAndReplace "bind-address" $shost
findAndReplace "log_bin" "\/var\/mysql\/log\/mysql-bin.log"
findAndReplace "server-id" $slaveServerId

stopMySQL

echo "Starting MySQL in safe mode.."
mysqld_safe --skip-slave-start & 2> /dev/null

sleep 2
dumpFileExists=`ls -l mysql_master_dump.db`

if [ "$?" != "0" ]; then echo "Dump file not found. Expected fileName is 'mysql_master_dump.db'"; exit 1; fi

echo "Restoring dump from file."
mysql -uroot -p$spassword < mysql_master_dump.db
echo "Restore complete."

stopMySQL

sleep 2
mysqld_safe --skip-slave-start & 2> /dev/null

sleep 2
mysql -uroot -p$spassword -e "CHANGE MASTER TO MASTER_HOST='$mhost', MASTER_USER='$susername', MASTER_PASSWORD='$spassword', MASTER_LOG_FILE='$log_file', MASTER_LOG_POS=$log_pos"

stopMySQL

/sbin/service mysqld start

mysql -uroot -p$spassword -e "show processlist"
mysql -uroot -p$spassword -e "show slave status"
mysql -uroot -p$spassword -e "show status like 'Slave%'"
