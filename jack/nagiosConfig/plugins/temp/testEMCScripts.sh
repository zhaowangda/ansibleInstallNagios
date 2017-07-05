#!/bin/sh

#echo "hello"
#exit 0

rate=`/opt/Navisphere/bin/naviseccli -h 10.1.1.101 storagepool -list |grep "Percent Full Threshold" |awk '{print $4}'`

echo "OK - using rate is $rate | rate=$rate"
exit 0


#capacity=`/opt/Navisphere/bin/naviseccli -h 10.1.1.101 storagepool -list |grep "Consumed Capacity (GBs)" |awk '{print $4}'`

#echo $rate
#echo $capacity
