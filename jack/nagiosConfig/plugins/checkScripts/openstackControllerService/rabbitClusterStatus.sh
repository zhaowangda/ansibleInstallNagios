#!/bin/sh

if [ -f /usr/sbin/rabbitmqctl ];
then 
	continue 
else
	echo "Error - rabbitmqctl  not exist!|status=0"
	exit 2
fi


result=`rabbitmqctl cluster_status |grep partitions |grep rabbit |wc -l`
#result=`rabbitmqctl cluster_status |grep partitions|wc -l`
if [ $? -ne 0 ];
then
	echo "Warning - Check command error!|status=0 "
	exit 1
elif [ $result == 0 ];
then
	echo "OK - rabbitmq cluster status is OK.|status=1"
	exit 0
else
	echo "Critical - rabbitmq cluster status is CRITICAL.|status=0"
	exit 2
fi
