#!/bin/sh
#----------------------------------------------------------------------------------------
#	Desc~	:	get IO of Disk info 
#	Example	:	./IOOfDisk.sh sda
#	Author 	:	Jack Zhao
#	Company	:	Chinac
#	Date	:	2016-10-8
#	Version	:	1.0
#
#-----------------------------------------------------------------------------------------

result=`iostat -d $1 -x -k | grep $1 `


readKBPS=`echo "$result" | awk -F '[ ]+' '{print $6}' | awk -F '[.]+' '{print $1}'`
writeKBPS=`echo "$result" | awk -F '[ ]+' '{print $7}'| awk -F '[.]+' '{print $1}'`
aWaitPms=`echo "$result" | awk -F '[ ]+' '{print $10}'| awk -F '[.]+' '{print $1}'`


#let "readKBPS=$VreadKBPS*1"

#let "writeKBPS=$VwriteKBPS*1"
#let "aWaitPms=$VwriteKBPS*1"


#echo "$readKBPS "

#echo "$writeKBPS"

#echo "$aWaitPms"
##################################################################
if [ $readKBPS -lt $2 -a $writeKBPS -lt  $3 -a $aWaitPms -lt $4 ]
then
   echo "OK - (KB) readKBPS=$readKBPS writeKBPS=$writeKBPS aWaitPms=$aWaitPms|readKBPS=$readKBPS writeKBPS=$writeKBPS aWaitPms=$aWaitPms"
   exit 0
else
   echo "CRITICAL - (KB) readKBPS=$readKBPS writeKBPS=$writeKBPS aWaitPms=$aWaitPms|readKBPS=$readKBPS writeKBPS=$writeKBPS aWaitPms=$aWaitPms"
   exit 2
fi
