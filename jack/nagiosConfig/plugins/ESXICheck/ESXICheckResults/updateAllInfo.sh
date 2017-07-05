#/bin/sh


while :
do



timeNow=`date +%Y-%m-%d' '%H:%M:%S`

echo "start at: " $timeNow >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

#-----------------------------------------------------------------------------------
/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXICPUUsage.sh


/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXIMemoryUsage.sh


/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXIIO.sh 


/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXINetUsage.sh


/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXIMemorySwap.sh 


/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/CheckESXIVmfs.sh

#-----------------------------------------------------------------------------------

timeNow=`date +%Y-%m-%d' '%H:%M:%S`

echo "finished at: " $timeNow >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

echo ""  >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

echo ""  >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

echo ""  >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

echo ""  >>/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/update.Log

sleep 60
done
