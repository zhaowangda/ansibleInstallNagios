#!/bin/sh
#----------------------------------------------------------------------------------------
#	Desc~	:	check MD5 of file 
#	Example	:	./checkFileMD5.sh filepath  md5code
#	Author 	:	Jack Zhao
#	Date	:	2017-6-29
#	Version	:	1.0
#
#-----------------------------------------------------------------------------------------

fileFullPath=$1
expectMD5Code=$2

result=`/usr/bin/md5sum  $1 |awk '{print $1}' `


if [ $result == $expectMD5Code ]
then
	echo "OK - $fileFullPath  md5 is correct: $expectMD5Code |status=1 "
else
	echo "CRITICAL - $fileFullPath md5 is error! expect MD5: $expectMD5Code;Act MD5: $result|status=0 "
fi



