#/bin/sh

#--------------------------------------------------------------
hostip="172.16.41.11"
esxiUser="nagios"
esxiPasswd="huayun@2016"
cpuWarning="90"
cpuCritical="110"
filePath="/usr/local/nagios/libexec/ESXICheck/ESXICheckResults/ESXiCPUResults.info"


#echo $hostip
#echo $esxiUser
#echo $esxiPasswd

#--------------------------------------------------------------
hostip="172.16.41.11"
timeNow=`date +%Y-%m-%d' '%H:%M:%S`

result=`/usr/local/nagios/libexec/check_esxi -H $hostip -u $esxiUser -p $esxiPasswd -l cpu -s usage -w $cpuWarning -c $cpuCritical`
echo $hostip $timeNow $result > $filePath

#--------------------------------------------------------------
hostip="172.16.41.12"
timeNow=`date +%Y-%m-%d' '%H:%M:%S`

result=`/usr/local/nagios/libexec/check_esxi -H $hostip -u $esxiUser -p $esxiPasswd -l cpu -s usage -w $cpuWarning -c $cpuCritical`
echo $hostip $timeNow $result >> $filePath

#--------------------------------------------------------------
hostip="172.16.41.10"
timeNow=`date +%Y-%m-%d' '%H:%M:%S`

result=`/usr/local/nagios/libexec/check_esxi -H $hostip -u $esxiUser -p $esxiPasswd -l cpu -s usage -w $cpuWarning -c $cpuCritical`
echo $hostip $timeNow $result >> $filePath
