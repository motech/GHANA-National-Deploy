#!/bin/bash

mysql -uroot -phab6czim -e "stop slave"
echo "Replication Slave stopped"
sleep 3
mysql -uroot -phab6czim -e "start slave"
echo "Replication Slave Started"
status=`mysql -uroot -phab6czim -e "show status like 'Slave%'"`
echo "`date` : $status" >> /root/pokeStatus.log
