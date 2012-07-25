#!/bin/bash

# MySQL Master configurator
. ./master.properties
. ./slave.properties

# rm -f /tmp/my.cnf

runningStatus=`/etc/init.d/mysqld status`
case $runningStatus in
	*stopped*)
	echo "MySQL is stopped, start and proceed with this script"
	exit 1;
esac

mysql -u$musername -p$mpassword -e "grant all on *.* to '$susername'@'$shost' identified by '$spassword'"

findAndReplace () {                            
found=""
if [ "`grep "$1" /etc/my.cnf`" == "" ]; then found="true"; fi

	if [ -z "$found" ]; then    
		sed "s/"$1".*=.*/"$1=$2"/g" /tmp/my.cnf > /tmp/my.cnf.bak
	else                
		sed '/\[mysqld\]/a\
'$1=$2'
		' /tmp/my.cnf > /tmp/my.cnf.bak  	                 
	fi                  
	mv /tmp/my.cnf.bak /tmp/my.cnf 

}                                              

findAndDisable () {
found=""
if [ "`grep "$1" /etc/my.cnf`" == "" ]; then found="true"; fi

        if [ -z "$found" ]; then
                sed "s/"$1".*=.*/#"$1"/g" /tmp/my.cnf > /tmp/my.cnf.bak
        else
                sed '/\[mysqld\]/a\
#'$1'
                ' /tmp/my.cnf > /tmp/my.cnf.bak
        fi
        mv /tmp/my.cnf.bak /tmp/my.cnf

}

# modify my.cnf properties                                                 
cp /etc/my.cnf /tmp/my.cnf
echo "Modifying/Inserting required properties"

findAndReplace "bind-address" "$mhost"
findAndReplace "log_bin" "\/var\/log\/mysql\/mysql-bin.log"
findAndReplace "server-id" "$masterId"
findAndReplace "innodb_flush_log_at_trx_commit" "1"
findAndReplace "sync_binlog" "1"
findAndDisable "skip-networking"
mv /etc/my.cnf /etc/my.cnf.repl.bak
mv /tmp/my.cnf /etc/my.cnf

echo "Creating mysql-bin file"
mkdir -p /var/log/mysql/
touch /var/log/mysql/mysql-bin.log
chmod -R 777 /var/log/mysql

echo "Restarting MySQL daemon..."
service mysqld restart

# Wait for some time, until user privileges are flushed
sleep 3
echo "Granting replication privileges to slave host"
mysql -u$musername -p$mpassword -e "delete from mysql.user where user='repl'"
mysql -u$musername -p$mpassword -e "delete from mysql.db where user='repl'"
mysql -u$musername -p$mpassword -e "flush privileges";
mysql -u$musername -p$mpassword -e "create user 'repl'@'$shost' identified by '$spassword'"
mysql -u$musername -p$mpassword -e "grant all on *.* to 'repl'@'$shost'";
mysql -u$musername -p$mpassword -e "flush privileges";

mysql -u$musername -p$mpassword -e "flush tables with read lock";
masterStatus=`mysql -u$musername -p$mpassword -e "show master status";`

log_file_name=`echo $masterStatus | awk '{ print $5 }'`
log_file_pos=`echo $masterStatus | awk '{ print $6 }'`

echo "################################################################"
echo -e "\tNote these values, required for slave configuration        "
echo -e "\tLog file name\t\t: " $log_file_name
echo -e "\tLog file position\t: " $log_file_pos
echo "################################################################"

echo "Taking MySQL dump of the entire DB."
mysqldump -u$musername -p$mpassword --all-databases --master-data > mysql_master_dump.db
mysql -u$musername -p$mpassword -e "unlock tables";

echo "Completed Taking dump. Find file named 'mysql_master_dump.db' "
