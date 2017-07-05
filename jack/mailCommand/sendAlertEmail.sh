#/bin/sh

sendEmail="/usr/sbin/sendEmail"
sender=wuxi-metro@chinac.com
recipient=$1
smtp=smtp.chinac.com
cipher=ZUpNT7:FfL6K@]vc19@VW3K2ZsQ]op
subject=$2
messageInfo=$3

$sendEmail -u "$subject" -t $recipient -m "$messageInfo"  -f $sender  -o tls=no  -s $smtp -xu  $sender -xp $cipher
