#!/bin/bash
#we use variable serverlist to keep server names
serverlist='inventory'
#we write in variable all server list
servers=`cat $serverlist`
#Step 1: Create Authentication SSH-Kegen Keys on host server.
#press Enter keys twince

ssh-keygen -t rsa

for i in `cat servers`; do cat ~/.ssh/id_rsa.pub | ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no root@$i 'mkdir -pm 0700 ~/.ssh &&
while read -r keytype keyname comment; do
if ! (grep -Fw "$keytype $keyname" ~/.ssh/authorized_keys | grep -qsvF "^#"); then
echo "$keytype $keyname $comment" >> ~/.ssh/authorized_keys
fi
done'; done
