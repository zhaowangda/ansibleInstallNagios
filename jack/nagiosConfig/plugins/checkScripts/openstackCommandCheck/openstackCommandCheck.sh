#!/bin/sh
#-----------------------------------------------------------------
#
#	Desc:		check openstack command exec result 
#	Date:		2017-05-16
#	Auther:		Jack Zhao
#	Dependence:	openstack Controller roles
#
#=================================================================

if  [ ! -n "$1" ]
then
        echo "Warning - check command is null !!|status=1  "
        exit 1	
fi
if [ ! -f "/root/adminrc" ]
then
        echo "Warning - This host is not controller role ,file '/root/adminrc not exist!'|status=1  "
        exit 1
fi


command=$1
source /root/adminrc			
info=`$command`

resultDown=` $command  |grep down |wc -l`
resultDisabled=`$command |grep disabled |wc -l`
resultError=`$command |grep error |wc -l `

if [[ ( $resultDown -ne 0 ) || ( $resultError -ne 0 ) ]]
then
	echo "Error - error exist in "$command" | status=2"
	exit 2
elif [ $resultDisabled -ne 0 ]
then
	echo "Warning - disabled exist in "$command" |status=1  "
	exit 1
else
	echo "OK - result: OK; command: "$command" |status=0 "
#	echo $info
	exit 0
fi
