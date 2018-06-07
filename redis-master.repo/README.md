# Ansible Redis
Install and configure [Redis](https://redis.io/) on Centos/Red Hat with Ansible

## Installation
- Clone this repository inside your ```roles``` directory

- In your playbook:

```yaml
roles:
  - redis
```

## Synopsis
Redis will be installed as a service in ```/etc/init.d/redis```
allowing commands such as ```service redis start``` and ```service redis stop```
for easy management.

## Usage

```yaml
vars:

  redis: { version: 4.0.9 }
```
