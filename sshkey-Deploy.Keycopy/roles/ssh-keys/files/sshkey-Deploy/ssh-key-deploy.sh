#!/bin/bash
#we use variable serverlist to keep server names
serverlist='servername'
#we write in variable all server list
servers=`cat $serverlist`
#Step 1: Create Authentication SSH-Kegen Keys on host server.
#press Enter keys twince
#
ssh-keygen -t rsa
#
for server in $servers
do
#Step 2: Copying ssh ID's on remote server
#
ssh-copy-id ${server} 
#
#Step 4: Login from Host server to remote Server and Set Permissions
#
ssh $USER@${server} "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
#
#end of for loop.
done