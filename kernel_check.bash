#!/bin/bash
#we user variable serverlist to keep there path to file with server names
serverlist='servername'
#we write in variable all server list
servers=`cat $serverlist`
#we use variable result to keep there path to file with result
result='result.txt'

#this print header to file with resilt using \t\t to add 2 tab symbols
echo -e "Servername \t\t kernel version"> $result
#this get each line of serverlist one by one and write to server variable
for server in $servers
do
#this login to server by ssh and get uname -r
kernel=`ssh root@${server} "uname -r"`
#this write server name and kernel version separated by 2 tab to result file
echo -e "$server \t\t $kernel" >> $result
#end of for loop.
done