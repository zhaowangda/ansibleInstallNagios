#!/bin/bash
#-------------CopyLeft---------------------------
 
#   Name:	Nagios check process Script demo  
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

count=`pgrep  $1 | wc -l`
if [ $count = 0 ]; then
	echo "Warning - process $1 is not runnning |ServiceStatus = 0"
	exit 2
else
	echo "OK - process $1 is running now.Resultinfo:$count|ServiceStatus = 1"
	exit 0
fi

#............Define Vars...............................
