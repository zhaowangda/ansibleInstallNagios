#!/bin/sh
##################################################################
status=3

################################################################
#echo init finished
##################################################################
rt=`df -h | awk '{if($6=="/"){print $5}}'`
info=`df -h | awk '{if($6=="/"){print "allSpaces:"$2 ";used:"  $3 ";free:" $4 ";usedPercent:" $5}}'`
rate=${rt//%/}
#echo $rate
#if [ $rate -le 50 ]
#then
#	echo "OK - The disk usage rate is  $rt .The detail info :$info |rate=$rate"
#	exit 0
#elif ( [ $rate -gt 50  ] && [ $rate -le 80 ] )	
#then 
#	echo "WARNING - The disk usage rate is : $rt .The detail info :$info |rate=$rate"
#        exit 1

if [ $rate -le 80 ]
then
        echo "OK - The disk usage rate is  $rt .The detail info :$info |rate=$rate"
        exit 0


elif [ $rate -gt 80 ]
then 
	echo "CRITICAL - The disk usage rate is : $rt . The detail info :$info |rate=$rate"
        exit 2
else
	echo "UNKNOWN - May be the script is not performed "
	exit 3
fi

