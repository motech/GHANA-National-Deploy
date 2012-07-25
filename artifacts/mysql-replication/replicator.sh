#!/bin/sh

. slave.properties
. master.properties

#echo "master-username = $musername"
#echo "master-password = $mpassword"
#echo "master-host = $mhost"

#echo "slave-username = $susername"
#echo "slave-password = $spassword"
#echo "slave-host = $shost" 


if [ `whoami` != 'root' ]; then
	echo "Can be exeucted only with root privileges"
	exit 1;
fi

if [[ -z "$1" ]]; then
	$isSlave = 'true'
fi               

if [ "$isSlave" != 'true' ]  then
	./slave.sh
else
	./master.sh
fi

