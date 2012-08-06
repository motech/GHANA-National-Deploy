#!/bin/bash

log_dir="/home/motech/motech-logs"
mkdir -p /root/archived_backups/logs
tar -pczf /root/archived_backups/logs/`date +"%Y-%m-%d-%H-%M-%S"`.tgz -C / home/motech/motech-logs
for filen in `ls $log_dir`;
 do
  if [[ "`find $log_dir -type f -printf '%T@ %p\n' | sort -n | tail -3 | cut -f2- -d' '`" != *$filen* ]]; then
   rm $log_dir/"$filen";
 fi;
done