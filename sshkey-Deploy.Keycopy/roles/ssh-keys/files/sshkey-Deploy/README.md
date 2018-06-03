SSH Key Deploy Script
=====================

script to simplify mangement of the authorized_keys file
* copy any .pub files which should be included into ./active/
* copy any .pub files which should be removed into ./remove/

Works great in combination with git. fork or copy the files into your own git repository
and add your public files to your git repository.     
This makes it easy to deploy your ssh keys accross multiple servers and could even be
used to rebuild authorized_keys automatically    


Examples
========

Update authorized_keys of the current user
* ./ssh-key-deploy.sh
    
Update specific file
* ./ssh-key-deploy.sh /home/foo/authorized_key


