#!/bin/sh
##################################################



##################################################
status=`free -m | grep Swap `
swapused=`echo $status |awk '{print $3}'`
swaptotal=`echo $status|awk '{print $2}'`
#swapused=100
rate=`echo "scale=4; $swapused * 100/ $swaptotal " | bc`
#echo $rate
if [ $swapused -eq 0 ]
then
        echo " OK - echo info(all/used/free): $status |rate=0 "
        exit 0
elif [ $swapused -gt 0 ] && [ $swapused -lt 1000 ]
then
        echo "WARNING - echo info(all/used/free): $status |rate=$rate% "
        exit 1
elif [ $swapused -ge 1000 ]
then
        echo "CRITICAL - echo info(all/used/free): $status |rate=$rate% "
        exit 2
fi
