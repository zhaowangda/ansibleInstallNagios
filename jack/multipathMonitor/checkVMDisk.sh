#!/bin/sh
#=====================================================================================
#	Function:	check vm network disk status
#	Author	:	Jack Zhao
#	Data	:	2017.4.27
#-------------------------------------------------------------------------------------
#mutipath Config
diskpathnumber=2
diskpathActive=3
#=====================================================================================
#define log function
#log (logInfo,logfilepath)
log (){
	timeNow=`date "+%Y%m%d %H:%M:%S"`
	echo $timeNow:"${1}"
	echo $timeNow:"${1}" >>$logFile
	
}

#------------------------------------------
errLog (){
        timeNow=`date "+%Y%m%d %H:%M:%S"`
        echo $timeNow:"${1}"
        echo $timeNow:"${1}" >>$errorLogFile

}

#------------------------------------------
writeErrorHostBasicInfo (){
		logInfo='#-------------vm-host------------------#'
                errLog "${logInfo}"

                logInfo="vm hostname: ""${vmHostName}"
                errLog "${logInfo}"

                logInfo="vm uuid    : ""${uuid}"
                errLog "${logInfo}"

                logInfo="hypervisor : ""${hypervisor}"
                errLog "${logInfo}"

                logInfo="diskInfo   : ""${diskInfo}"
                errLog "${logInfo}"
		hostStatusSignal=1
	
}
#=====================================================================================
#init log file and global VARS

logDirPath=/var/log/chinacVMDiskPathLog/
[ -d /var/log/chinacVMDiskPathLog/ ];mkdir -p /var/log/chinacVMDiskPathLog/
fileNameTime=`date "+%Y%m%d-%H%M%S"`
logFile=$logDirPath$fileNameTime'.log'
errorLogFile=$logDirPath$fileNameTime'.err.log'
[ -f $logFile ];touch $logFile
[ -f $errorLogFile ];touch $errorLogFile

#------------------------------------------
#Write log script begin
logInfo="================check-process-begin================"
log $logInfo $logFile
#=====================================================================================

logInfo='------multpath-config-info-----'
log $logInfo $logFile


logInfo="mutipathnumber:"$diskpathnumber
log $logInfo $logFile

logInfo='------multpath-config-----'
log $logInfo $logFile
#echo diskpathActive: $diskpathActive
#=====================================================================================
#get vmid array of current compute node

vmIdList=`virsh list | grep running |awk '{print $1}' `

#echo $vmIdList

#-------------------------------------------------------------------------------------
#get one vmid network disk status & mutipath status
for vmid in $vmIdList
do
	hostStatusSignal=0
	diskInfo=`virsh domblklist $vmid | grep /dev/ |awk '{print $2}'`
	result=`virsh domblklist $vmid  | grep /dev | grep disk|wc -l`
	vmuuid=`virsh dumpxml $vmid  | grep '<uuid>' `
	temp=${vmuuid//<uuid>/''}
	uuid=${temp//'</uuid>'/''}
	#echo $uuid
	vmHostName=`source ~/adminrc && nova show $uuid| grep '| name'|awk {'print $4'} `
        hypervisor=`source ~/adminrc && nova show $uuid| grep 'hypervisor' |awk {'print $4'} `
	logInfo='#-------------vm-host------------------#'
	log "${logInfo}" $logFile
        #echo vm hostname: $vmHostName
	logInfo="vm hostname: ""${vmHostName}"
        log "${logInfo}" $logFile

        #echo vm uuid    : $uuid
        logInfo="vm uuid    : ""${uuid}"
        log "${logInfo}" $logFile

        #echo hypervisor : $hypervisor
        logInfo="hypervisor : ""${hypervisor}"
        log "${logInfo}" $logFile

        #echo diskInfo   : $diskInfo
        logInfo="diskInfo   : ""${diskInfo}"
        log "${logInfo}" $logFile



	#------------------------------------------------------
	#get disk mutipath status of cureent vmid

	if [ $result == 0 ]
	then
		#echo storagePathstate: ok
		logInfo="storagePathstate: OK"
		log "${logInfo}" $logFile
	else
		
		logInfo='#-------------vm-host------------------#'
        	errLog "${logInfo}"
        	
		logInfo="vm hostname: ""${vmHostName}"
        	errLog "${logInfo}"

        	logInfo="vm uuid    : ""${uuid}"
        	errLog "${logInfo}"

        	logInfo="hypervisor : ""${hypervisor}"
        	errLog "${logInfo}"
        	
		logInfo="diskInfo   : ""${diskInfo}"
		errLog "${logInfo}"
	
                logInfo="storagePathstate: Error - This disk is not network disk"
                errLog "${logInfo}"
		log "${logInfo}"
		hostStatusSignal=1
	fi




	#-------------------------------------------------
	for diskline in $diskInfo
	do
		#get diskid
		diskid=${diskline/\/dev\/mapper\//''}
		logInfo="diskID : ""${diskid}"
		log "${logInfo}" $logFile
		multipath=`/usr/sbin/multipath -l $diskid`
		multipathRuning=`/usr/sbin/multipath -l $diskid |grep running |wc -l`
		#-------------
		multipathActive=`/usr/sbin/multipath -l $diskid |grep active |wc -l`
		#==============================================================================================
		#get multipathRuning state
		if [ $multipathRuning  == $diskpathnumber ]
		then
			#echo multipath running is $multipathRuning : ok - multipathRuning number is correct.
			logInfo="multipath running is ""${multipathRuning}"" : ok - multipathRuning number is correct."
                	log "${logInfo}" $logFile
			if [ $hostStatusSignal != 0 ]
			then
				
				errLog "${logInfo}"
			fi
		elif [ $multipathRuning -gt $diskpathnumber ]
		then
			#echo multipath running $multipathRuning : Warning - multipathRuning number is great than config!
                        logInfo="multipath running is ""${multipathRuning}"" : Warning - multipathRuning number is great than config!"
                        log "${logInfo}" $logFile
			#----
			if [ $hostStatusSignal == 0 ]
			then
				writeErrorHostBasicInfo
				errLog "${logInfo}"
			else
				errLog "${logInfo}"
			fi
		else :
			#echo multipath running $multipathRuning : error - multipathRuning number is less than config!
                        logInfo="multipath running is ""${multipathRuning}""  : error - multipathRuning number is less than config!"
                        log "${logInfo}" $logFile
			if [ $hostStatusSignal == 0 ]
                        then
                                writeErrorHostBasicInfo
                                errLog "${logInfo}"
                        else
                                errLog "${logInfo}"
                        fi
		fi
		#=============================================================================================
		if [ $multipathActive  == $diskpathActive ]
                then
                        #echo multipath active $multipathActive : ok - multipathActive number is correct.
                        logInfo="multipath active is ""${multipathActive}"" : ok - multipathActive number is correct."
                        log "${logInfo}" $logFile
			if [ $hostStatusSignal != 0 ]
                        then

                                errLog "${logInfo}"
                        fi

                elif [ $multipathActive -gt $diskpathActive ]
                then
                        #echo multipath active $multipathActive : Warning - multipathActive number is great than config!
                        logInfo="multipath active is ""${multipathActive}"" : Warning - multipathActive number is great than config!"
                        log "${logInfo}" $logFile
                        if [ $hostStatusSignal == 0 ]
                        then
                                writeErrorHostBasicInfo
                                errLog "${logInfo}"
                        else
                                errLog "${logInfo}"
                        fi
                else :
                        #echo multipath active $multipathActive : error - multipathActive number is less than config!
			logInfo="multipath active is ""${multipathActive}"" : error - multipathActive number is less than config!!!"
                        log "${logInfo}" $logFile
                        if [ $hostStatusSignal == 0 ]
                        then
                                writeErrorHostBasicInfo
                                errLog "${logInfo}"
                        else
                                errLog "${logInfo}"
                        fi
                fi	
		#=============================================================================================
		echo 	
		#=============================================================================================
		lineNumber=`multipath -l $diskid |grep running |wc -l`
		#echo $lineNumber
		
		logInfo='#-------multipath-info------------'
		log "${logInfo}" $logFile

		for ((i=1;i<=$lineNumber; ++i))
		#for i in {1..$lineNumber}
		do
			if [ $i == 1 ] 
			then
				#echo `multipath -l $diskid |grep running |awk '{if(NR=='$i') print $4 " " $6 " " $8}'`
				logInfo=`multipath -l $diskid |grep running |awk '{if(NR=='$i') print $4 " " $6 " " $8}'`
				log "${logInfo}" $logFile
			else
				#echo `multipath -l $diskid |grep running |awk '{if(NR=='$i') print $3 " " $5 " " $7}'`
				logInfo=`multipath -l $diskid |grep running |awk '{if(NR=='$i') print $3 " " $5 " " $7}'`
                                log "${logInfo}" $logFile
			fi

                        if [ $hostStatusSignal != 0 ]
                        then

                                errLog "${logInfo}"
                        fi
		done
		logInfo="************************"
		log "${logInfo}" $logFile
		log "${logInfo}" $logFile
		log "${logInfo}" $logFile
		if [ $hostStatusSignal != 0 ]
                then
			errLog "${logInfo}"
			errLog "${logInfo}"
			errLog "${logInfo}"
                fi
	done
	hostStatusSignal=0

        echo '#-----------Next-vm-Host----------------------'
done

if [ -s $errorLogFile ]; then
	 cat  $errorLogFile  |/usr/sbin/sendAlertEmail.sh  zhaowangda@chinac.com "testVMMultipathAlert"
	 cat  $errorLogFile  |/usr/sbin/sendAlertEmail.sh  chenming@chinac.com "testVMMultipathAlert"
	 cat  $errorLogFile  |/usr/sbin/sendAlertEmail.sh  duxinlong@chinac.com "testVMMultipathAlert"
	 cat  $errorLogFile  |/usr/sbin/sendAlertEmail.sh  liujie@chinac.com "testVMMultipathAlert"
	 cat  $errorLogFile  |/usr/sbin/sendAlertEmail.sh  tangxianglian@chinac.com "testVMMultipathAlert"
fi
