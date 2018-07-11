# Ansible Role: png-pumaws.repo

Installs [pumaws](http://dist.pngaming.com) on Linux and Centos 7.x.

## Requirements
```
RedHat-based distributions, requires the EPEL repository.
use the role `png-pumaws.repo` to install and ensure EPEL is available.
```
# Puma WS Install/Setup 

```
$ sudo yum install puma2ws
$ sudo mkdir -p /etc/systemd/system/httpd.service.d/
$ cd /var/www/puma/config
$ sudo cp nopt.conf /etc/systemd/system/httpd.service.d/.
$ sudo systemctl daemon-reload
$ sudo systemctl restart httpd
$ sudo firewall-cmd --zone=internal --permanent --add-port=443/tcp
$ sudo firewall-cmd --reload
```
# Install of the conf/certs ---
Copy over the certs.tgz and the puma.conf, `puma.conf `is in source control, and part of the RPM

# Install this in the right directory
```
$ sudo cp puma.conf /etc/httpd/conf.d/.
```
Change the `ServerName` in puma.conf based on the environment

# Set application environmental variables
```
$ sudo cp certs/domain.cer /etc/pki/tls/certs/domain.cer
$ sudo cp certs/domain.key /etc/pki/tls/private/domain.key
$ sudo cp certs/domain-ca.crt /etc/pki/tls/certs/domain-ca.crt
```
# updates to the configd in the db
```
$ sudo systemctl restart httpd
```
#Before running this playbook
```
Change the ServerName in puma.conf based on the environment
```
## Role Variables
```
 puma_enablerepo: epel

```
## Dependencies
```
None.
```
## Example Playbook
```
    - hosts: all
      roles:
        - role: png-pumaws.repo
```

# Bug or Error to be fix from nopt.conf
```
TASK [png-pumaws.repo : Reload systemd for puma-ws] ******************************
fatal: [coloredhat2.pngaming.com]: FAILED! => {"changed": false, "msg": "Error loading unit file
 'httpd': org.freedesktop.DBus.Error.InvalidArgs \"Invalid argument\""}
```
## License
```
None
```
## Author Information
```
None
```
#Creating png.repo
```
[Puma2]
name=PNG Puma2 Packages Enterprise Linux 7 - $basearch
baseurl=http://dist.pngaming.com/repositories-new/Puma2/$yum_env/noarch
failovermethod=priority
enabled=1
gpgcheck=0
proxy=_none_
```
# Based on environment, echo "snapshot","test", or "prod"
to /etc/yum/vars/yum_env
```
$ echo "test" > /etc/yum/vars/yum_env
```
From there, you can copy the repo into `/etc/yum.repos.d`
and then run yum update and it should have the new repo
