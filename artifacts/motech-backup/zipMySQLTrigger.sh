#!/bin/bash

mysqldb_dir="/root/archived_backups/mysql"
mkdir -p $mysqldb_dir
tar -pczf /root/archived_backups/mysql/`date +"%Y-%m-%d-%H-%M-%S"`.tgz -C / var/lib/mysql
for filen in `ls $mysqldb_dir`; do if [[ "`find $mysqldb_dir -type f -printf '%T@ %p\n' | sort -n | tail -3 | cut -f2- -d' '`" != *$filen* ]]; then rm $mysqldb_dir/"$filen"; fi; done
