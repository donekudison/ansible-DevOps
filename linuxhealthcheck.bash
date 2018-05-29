#!/bin/bash 
#Here we put email address to send email with report.
# If no email provided – log file will be just saved.

EMAIL=''
function sysstat {
echo -e "

#Print header, hostname (hostname command used), Kernel version (uname -r)
#Uptime (from uptime command) and Last reboot time (from who command)

#####################################################################
    Health Check Report (CPU,Process,Disk Usage, Memory)
#####################################################################


Hostname         : `hostname`
Kernel Version   : `uname -r`
Uptime           : `uptime | sed 's/.*up \([^,]*\), .*/\1/'`
Last Reboot Time : `who -b | awk '{print $3,$4}'`



*********************************************************************
CPU Load - > Threshold < 1 Normal > 1 Caution , > 2 Unhealthy 
*********************************************************************
"
#Here we check if mpstat command is in our system

MPSTAT=`which mpstat`

#We get exit code from previous command

MPSTAT=$?

#if exit status in not 0, this means that mpstat command is not found (or not exist in our system)

if [ $MPSTAT != 0 ]
then
	echo "Please install mpstat!"
	echo "On Debian based systems:"
	echo "sudo apt-get install sysstat"
	echo "On RHEL based systems:"
	echo "yum install sysstat"
else
echo -e ""

#Here we check in same way if lscpu installed

LSCPU=`which lscpu`
LSCPU=$?
if [ $LSCPU != 0 ]
then
	RESULT=$RESULT" lscpu required to producre acqurate reults"
else

#if we have lscpu installed, we can get number of CPU's on our system and get statistic for each using mpstat command.

cpus=`lscpu | grep -e "^CPU(s):" | cut -f2 -d: | awk '{print $1}'`
i=0
while [ $i -lt $cpus ]
do
	echo "CPU$i : `mpstat -P ALL | awk -v var=$i '{ if ($3 == var ) print $4 }' `"
	let i=$i+1
done
fi
echo -e "
Load Average   : `uptime | awk -F'load average:' '{ print $2 }' | cut -f1 -d,`

Heath Status : `uptime | awk -F'load average:' '{ print $2 }' | cut -f1 -d, | awk '{if ($1 > 2) print "Unhealthy"; else if ($1 > 1) print "Caution"; else print "Normal"}'`
"
fi
echo -e "
*********************************************************************
                             Process
*********************************************************************

=> Top memory using processs/application

PID %MEM RSS COMMAND
`ps aux | awk '{print $2, $4, $6, $11}' | sort -k3rn | head -n 10`

=> Top CPU using process/application
`top b -n1 | head -17 | tail -11`

*********************************************************************
Disk Usage - > Threshold < 90 Normal > 90% Caution > 95 Unhealthy
*********************************************************************
"
#we get disk usage with df command. -P key used to have postfix like output.
# We print output to temp file to work with info more than one.

df -Pkh | grep -v 'Filesystem' > /tmp/df.status

#We create loop to process line by line from df.status

while read DISK
do

#Here we get line from df.status and print result formatted with awk command

	LINE=`echo $DISK | awk '{print $1,"\t",$6,"\t",$5," used","\t",$4," free space"}'`
	echo -e $LINE 
	echo 
done < /tmp/df.status
echo -e "

Heath Status"
echo

#Here almost same loop, but we check disk usage, and print Normal if value less 90, Caution if between 90 and 95, and Unhealthy if greater than 95).

while read DISK
do
	USAGE=`echo $DISK | awk '{print $5}' | cut -f1 -d%`
	if [ $USAGE -ge 95 ] 
	then
		STATUS='Unhealty'
	elif [ $USAGE -ge 90 ]
	then
		STATUS='Caution'
	else
		STATUS='Normal'
	fi
		
        LINE=`echo $DISK | awk '{print $1,"\t",$6}'`
		
#Here we print result with status

        echo -ne $LINE "\t\t" $STATUS
        echo 
done < /tmp/df.status

#Here we remove df.status file

rm /tmp/df.status

#here we get Total Memory, Used Memory, Free Memory, Used Swap and Free Swap values and save them to variables.

TOTALMEM=`free -m | head -2 | tail -1| awk '{print $2}'`

#All variables like this is used to store values as float (we are using bc to make all mathematics operations, since without bc all values will be integer).
#Also we use if to add zero before value, if value less than 1024, and result of dividing will be less than 1.

TOTALBC=`echo "scale=2;if($TOTALMEM<1024 && $TOTALMEM > 0) print 0;$TOTALMEM/1024"| bc -l`
USEDMEM=`free -m | head -2 | tail -1| awk '{print $3}'`
USEDBC=`echo "scale=2;if($USEDMEM<1024 && $USEDMEM > 0) print 0;$USEDMEM/1024"|bc -l`
FREEMEM=`free -m | head -2 | tail -1| awk '{print $4}'`
FREEBC=`echo "scale=2;if($FREEMEM<1024 && $FREEMEM > 0) print 0;$FREEMEM/1024"|bc -l`
TOTALSWAP=`free -m | tail -1| awk '{print $2}'`
TOTALSBC=`echo "scale=2;if($TOTALSWAP<1024 && $TOTALSWAP > 0) print 0;$TOTALSWAP/1024"| bc -l`
USEDSWAP=`free -m | tail -1| awk '{print $3}'`
USEDSBC=`echo "scale=2;if($USEDSWAP<1024 && $USEDSWAP > 0) print 0;$USEDSWAP/1024"|bc -l`
FREESWAP=`free -m |  tail -1| awk '{print $4}'`
FREESBC=`echo "scale=2;if($FREESWAP<1024 && $FREESWAP > 0) print 0;$FREESWAP/1024"|bc -l`

echo -e "
*********************************************************************
		     Memory 
*********************************************************************

=> Physical Memory

Total\tUsed\tFree\t%Free

#As we get values in GB, also we get % of usage dividing Free by Total

${TOTALBC}GB\t${USEDBC}GB \t${FREEBC}GB\t$(($FREEMEM * 100 / $TOTALMEM  ))%

=> Swap Memory

Total\tUsed\tFree\t%Free

#Same as above – values in GB, and in same way we get % of usage

${TOTALSBC}GB\t${USEDSBC}GB\t${FREESBC}GB\t$(($FREESWAP * 100 / $TOTALSWAP  ))%
"
}
#here we make filename value, using hostname, and date.

FILENAME="health-`hostname`-`date +%y%m%d`-`date +%H%M`.txt"

#here we run function and save result to generated filename

sysstat >> $FILENAME

#here we print output to user.

echo -e "Reported file $FILENAME generated in current directory." $RESULT

#here we check if user provide his email address to send email

if [ "$EMAIL" != '' ] 
then
#if email is provided – we check if we have mailx command to send email

	STATUS=`which mail`
	
#if mailx command not exist on system (previous command returned non-zero exit code we warn user that mailx is not installed

	if [ "$?" != 0 ] 
	then
		echo "The program 'mail' is currently not installed."
	
	#if mailx installed, we send email with report to user
	else
		cat $FILENAME | mail -s "$FILENAME" $EMAIL
	fi
fi
