Ansible playbook to lockdown super-uer
=====================================

To prevent users from logging in directly as root.
 
The system administrator can set the root account's shell to:
```
 /sbin/nologin in the /etc/passwd file.
```

Affected access privilleges 
===============================

 Prevents access to the root shell and logs any such attempts. 
The following programs are prevented from accessing the root account:
 ```
 login,
 gdm,
 kdm,
 xdm,
 su,
 ssh,
 scp,
 sftp,
```
####
Programs that do not require a shell, such as FTP clients, mail clients, and many setuid programs.
 The following programs are not prevented from accessing the root account:
```
 sudo,
 FTP clients,
 Email clients
```