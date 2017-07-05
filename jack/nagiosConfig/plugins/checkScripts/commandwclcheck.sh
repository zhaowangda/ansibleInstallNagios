#!/bin/sh
#-----------------------------------------------------------------
#
#	Desc:		command exec result 
#	Date:		2017-05-16
#	Auther:		Jack Zhao
#	Dependence:	argsneeded=2
#	example:
#		./scripts "rabbitmqctl list_policies  |grep ha-all " "0"
#=================================================================

if  [ ! -n "$1" ]
then
        echo "Warning - check command is null !!|status=1  "
        exit 1	
fi

if [ ! -n "$2" ]
then
	echo "Warning - check command need keyword |status=1 !!"
	exit 1
fi


if  [ ! -n "$3" ]
then
        echo "Warning - check command  expected result  !!|status=1  "
        exit 1
fi

commandStr="${1}"
keyword="${2}"
expectedResult=$3

if [ -f /root/adminrc ]
then
	source /root/adminrc
fi

info=`$commandStr | grep $keyword `

result=`$commandStr | grep $keyword |wc -l `

#echo $info
#echo $result

if [ $result -ne $expectedResult ]
then
	echo "Error - commnad: "$commandStr"; keyword: "$keyword" ;expectedResult:$expectedResult ;ActResult: $result   |status=2"
	#echo $info
	exit 2
else
	echo "OK - commnad: "$commandStr"; keyword: "$keyword" ;expectedResult:$expectedResult ;ActResult: $result  |status=0 "
	#echo $info
	exit 0
fi
