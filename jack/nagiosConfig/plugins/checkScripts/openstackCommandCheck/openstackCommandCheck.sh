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

if [ $? -ne 0 ]
then
        echo "Unkown - command "$command" execute failed! | status=3"
        exit 3
fi



result=`echo $info  | grep -E '(error|down|disabled)' | wc -l `


if [  $result -ne 0  ]
then
        echo "Critical - error exist in "$command" ;info:$info| status=2"
        exit 2
else
        echo "OK - result: OK; command: "$command";info:$info |status=0 "
#       echo $info
        exit 0
fi