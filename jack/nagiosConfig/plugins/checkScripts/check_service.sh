#!/bin/bash
#-------------CopyLeft---------------------------
 
#   Name:	Nagios check Memory Script demo  
#   Version:	1.0
#   Language:	bash shell  
#   Date:	2005-10-26  
#   Author:	BitBull  
#   Email:	zhaowangda@chinac.com;zhaowangda@126.com  

#------------Environment--------------------------  

#   Terminal: column 80 line 24  
#   system:	centos 7.2 
#   tools:	Vim

#------------Friendly Remind-----------------------
#.......................................................

servicename=$1

serviceInfo=`service  $servicename status | grep running `
if [ "$serviceInfo" = "" ]; then
	echo "Warning - Service  $servicename is not runnning |ServiceStatus = 0"
	exit 2
else
	echo "OK - Service  $servicename is running now.Resultinfo:$serviceInfo|ServiceStatus = 1"
	exit 0
fi

#............Define Vars...............................
