#!/bin/bash
couchdb_dir="/root/archived_backups/couch"
mkdir -p $couchdb_dir
tar -pczf /root/archived_backups/couch/`date +"%Y-%m-%d-%H-%M-%S"`.tgz -C / var/lib/couchdb
for filen in `ls $couchdb_dir`; do if [[ "`find $couchdb_dir -type f -printf '%T@ %p\n' | sort -n | tail -3 | cut -f2- -d' '`" != *$filen* ]]; then rm $couchdb_dir/"$filen"; fi; done
