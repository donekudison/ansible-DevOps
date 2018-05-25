#!/bin/bash

#clear console
clear

#just echo welcome messages
echo "This is information provided by $0 . Program starts now."

echo "Hello, $USER"

echo

#print today's date
echo "Today's date is `date`, this is week `date +"%V"`."

echo

#list of currently loged user via w command.
echo "These users are currently connected:"

w | cut -d " " -f 1 - | grep -v USER | sort -u

echo

#info about system with command uname and keys -m and -s
echo "This is `uname -s` running on a `uname -m` processor."

echo

#info about uptime, using uptime command
echo "This is the uptime information:"

uptime

echo

#info about free memory via free command
echo "Free memory:"

free

echo

#info about disk usage
echo "Disk usage:"

df -kh

echo

