#!/bin/sh

# MySQL Slave machine configuration

echo "Stop Slave Mysql Instance"
/etc/init.d/mysqld stop

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

findAndReplace "bind-address" $shost
findAndReplace "log_bin" "\/var\/mysql\/log\/mysql-bin.log"
findAndReplace "server-id" $slaveServerId


