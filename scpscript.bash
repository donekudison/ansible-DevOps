#!/bin/bash
#next line prints copy files or directory 
echo "Interactive Script to Copy File (files) / Directory using scp"

#check if entered value is not null, 
#if null it will reask user to enter Destination Server
while [ x$desthost = "x" ]; do
#prints what userd should enter, and stores entered value to variable with name desthost
read -p "Destination Server Name : " desthost

#Finishes while loop
done
#check if entered value is not null, and if null it will ask user to enter Destination Path
while [ x$destpath = "x" ]; do
#Prints what userd should enter,
#stores entered value to variable with name destpath
read -p "Destination Path : " destpath

#Finishes while loop
done
#Put null value to variable filename
filename='null'
#check if entered value is null, and If not null it will reask user to enter file(s) to copy
while ! [ x"$filename" = "x" ]; do
#prints what userd should enter, and stores entered value to variable with name filename
read -p "Path to source directory / file : " filename
#checks if entered value is not null, and if not null it will copy file(s)
if ! [ x"$filename" = "x" ];
then
#next line prints header
echo -n "Copying $filename ... "
#copy pre-entered file(s) or dir to destination path on destination server
scp -r "$filename" "$desthost":"$destpath"
#end of if
fi
#End of while loop
done