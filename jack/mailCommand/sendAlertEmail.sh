#/bin/sh

sendEmail="/usr/sbin/sendEmail"
sender=
recipient=$1
smtp=
cipher=
subject=`iconv -t GB2312 -f UTF-8  << EOF
$2
EOF`

#messageInfo=`iconv -t GB2312 -f UTF-8  << EOF
#$3
#EOF`




#subject=$2
messageInfo=$3


$sendEmail -u "$subject" -t $recipient -m "$messageInfo"  -f $sender  -o tls=no -s $smtp -xu  $sender -xp $cipher  
#-o message-charset=GB2312 -o message-header=GB2312
