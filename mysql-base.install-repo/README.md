Ansible Script for mysql and install Deploy
===========================================
Ansible role that installs [MYSQL](https://dev.mysql.com/downloads/mysql/) on:

* Centos/RHEL 7.x

Description
===========
This ansible playbook  download the latest version of mysql, python and get-pip


Examples
========

- To deploy the db-mysql-playbook onto a a remote client. 
```  
$  ansible-playbook -i inventory mysql-repoconf/test-play.yml --sudo
```
-  If root user password failed to set. Run the below
```  
example:$ ansible -i inventory <servername> -m shell -a "mysql_upgrade"

$ ansible -i inventory ansible -m shell -a "mysql_upgrade"
```
