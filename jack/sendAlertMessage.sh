#/bin/sh

sendMobileMessage="/usr/bin/mysql"
sendEmail="/usr/sbin/sendEmail"
#-------------------------------------------------------
#mail alert config
sender=hii-notice@chinac.com
smtp=smtp.chinac.com
cipher=PxQ3GS5!PxQ3GS5!

#----------------------------------
#message alert config
mysqlServer=10.1.254.251
mysqlPort=3366
mysqlUser=mas
mysqlpasswd=JXmas@2012
#-----------------------------------

#---------------------------------------------
recipient=$1
subject=$2
messageInfo=$3

#---------------------------------------------
#test vars
#messageInfo='\n ****Nagios Alert**** \n Host: 192.168.1.1 \n Status: Down \n Date/Time:2017-05-08 17:50'
#recipient=15861675323
#---------------------------------------------

$sendMobileMessage -h $mysqlServer -P $mysqlPort -u$mysqlUser -p$mysqlpasswd -e "use dbadapter;insert into sms_outbox(sismsid,extcode,destaddr,messagecontent,reqdeliveryreport,msgfmt,sendmethod,requesttime,applicationid)values(UUID(),'','$recipient','$messageInfo',1,15,0,now(),'2017db');"


