# Ansible Role: ActiveMQ

An Ansible role that installs [ActiveMQ](http://activemq.apache.org/) on:

* Centos/RHEL 7.x

## Role Variables

Available variables are listed below, along with default values:

What version to install:
```
activemq_version: 5.15.4
```

Where to install to:
```
activemq_install_root: /opt
```
Symbolic link to:
```
activemq -> /opt/apache-activemq-5.15.4
```

User\group to install as:
```
activemq_user: activemq
activemq_group: activemq
```

## Dependencies

* None
  
## Example Playbook
```
    - hosts: webservers
      roles:
        - { role: activemq.png.install }
```
## How to run this playbook
```
$ ansible-playbook -i inventory  activemq-install.repo/test-repo.yml --sudo

```
## ActiveMq Service
```
PIDFile=/opt/activemq/data/activemq.pid
WorkingDirectory=/opt/activemq/bin
ExecStart=/opt/activemq/bin/activemq start
ExecStop=/opt/activemq/bin/activemq stop
It will restart on abort

```
## QUERY FILES
```
sudo sh /opt/activemq/bin/activemq query

```
## License

None