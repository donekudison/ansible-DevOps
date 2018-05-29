#!/bin/bash

# script to simplify mangement of the authorized_keys file
# * copy any .pub files which should be included into ./active/
# * copy any .pub files which should be removed into ./remove/
#
#
# Author: Mirko Kaiser, http://www.KaiserSoft.net
# Project URL: https://github.com/KaiserSoft/SSH-Key-Deploy/
# Support the software with Bitcoins !thank you!: 157Gh2dTCkrip8hqj3TKqzWiezHXTPqNrV
# Copyright (C) 2015 Mirko Kaiser
# First created in Germany on 2015-09-20
# License: New BSD License
#
# Example for current user: ./ssh-key-deploy.sh
# Example with custom keys file: ./ssh-key-deploy.sh /home/foo/authorized_key


AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"

# custom authorized keys file passed
if [ -n "$1" ]; then
	if [ "$1" != '--force' ]; then
	        AUTHORIZED_KEYS=$1
	fi

	if [ -n "$2" ]; then
		AUTHORIZED_KEYS=$2
	fi

	printf "Custom authorized_keys file used. Please double check user permissions\n"
fi


# determine path as it may be passed to the script 
AUTH_LEN=`printf "$AUTHORIZED_KEYS" |  awk -F"/" '{ print $NF }' | wc -m`
STR_LEN=`printf "$AUTHORIZED_KEYS" | wc -m`
let "STR_CUT=$STR_LEN - $AUTH_LEN"
STR_PATH=`printf "$AUTHORIZED_KEYS" | cut -c-$STR_CUT`

# ensure the required directory exists
if [ ! -d "$STR_PATH" ]; then
        mkdir "$STR_PATH"
	if [ $? -ne 0 ]; then
		printf "ERROR: unable to create $STR_PATH\n"
		exit 99
	fi
        chmod 0700 "$STR_PATH"
fi

# ensure that authorized_keys exists
if [ ! -f "$AUTHORIZED_KEYS" ]; then
        touch "$AUTHORIZED_KEYS"
	if [ $? -ne 0 ]; then
		printf "ERROR: unable to create $AUTHORIZED_KEYS\n"
		exit 99
	fi
        chmod 0600 "$AUTHORIZED_KEYS"
fi


# process parameters
case "$1" in
	'--help')
		printf "\n./ssh-key-add.sh\t\t deploy keys to current account\n"
		printf "./ssh-key-add.sh --force\t delete authorized_key file first\n"
		printf "./ssh-key-add.sh --force <path/to/authorized_keys>\t custom file\n\n"
		exit 1
	        ;;

	'--force')
		printf "Using: $AUTHORIZED_KEYS\n"
		RET=`rm $AUTHORIZED_KEYS 2>&1`
		if [ $? -ne 0 ]; then
			printf "ERROR: clearing file: $RET\n\n"
			exit 1
		fi
		RET=`touch $AUTHORIZED_KEYS 2>&1`
		if [ $? -eq 0 ]; then
			printf "File cleard due to --force\n"
		else
			printf "ERROR: creating empty file: $RET\n\n"
			exit 1
		fi
                ;;

	*)
		printf "Using: $AUTHORIZED_KEYS\n"
		;;
esac




# create backup
if [ "$1" != '--force' ] && [ -f "$AUTHORIZED_KEYS" ]; then
	KEY_BACK=$AUTHORIZED_KEYS".deploy"
	cp "$AUTHORIZED_KEYS" "$KEY_BACK"
	printf "Backup: $KEY_BACK\n"
fi


# process keys to be added
find ./active/ -maxdepth 1  -type f -name "*.pub" | while read FOUND 
do

	CONTENT=`cat $FOUND`

	grep "$CONTENT" "$AUTHORIZED_KEYS" &> /dev/null
	if [ $? -ne 0 ]; then
		#key not in authorized key file, add it
		cat "$FOUND" 2> /dev/null >> "$AUTHORIZED_KEYS"
		if [ $? -ne 0 ]; then
			printf "  * error writing to file\n"
		else
			printf "  + key added $FOUND\n"
		fi
	fi 
done




# process key removal 
find ./remove/ -maxdepth 1 -type f -name "*.pub" | while read FOUND
do

        CONTENT=`cat $FOUND`
        RET=`grep -n "$CONTENT" "$AUTHORIZED_KEYS" 2> /dev/null`
		item_src=`echo "$RET" |  awk -F":" '{print $1}'`

        if [ $? -eq 0 ]; then

		# prepare lines numbers for sed operation
		for item in ${item_src[@]}
		do

		        SEDOPTS="$SEDOPTS${item}d;"

		done

		if [ -n "$SEDOPTS" ]; then
			RETSED=`sed ${SEDOPTS}  < "$AUTHORIZED_KEYS" 2> /dev/null`
			if [ $? -ne 0 ]; then
                        	printf "  * error reading file\n"
			else

        	        	echo "$RETSED" > "$AUTHORIZED_KEYS"
                		if [ $? -ne 0 ]; then
                        		printf "  * error writing to file\n"
                		else
                        		printf "  - key removed $FOUND\n"
                		fi
			fi
		fi


        fi
done
