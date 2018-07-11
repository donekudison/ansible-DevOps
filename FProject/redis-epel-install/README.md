# Ansible Role: Redis

Installs [Redis](http://redis.io/) on Linux and Centos 7.x.


# Install and Configure Redis steps-by-steps

Before You Begin seethis guides [linodeguides](https://linode.com/docs/databases/redis/install-and-configure-redis-on-centos-7/)

# How to setup Redis master and slave replication

Redis master and slave replication setup [redis-M-S](https://community.pivotal.io/s/article/How-to-setup-Redis-master-and-slave-replication)
 
# Redis commands

Some useful redis command line [Redis Commands](https://redis.io/commands)

## Requirements
```
On RedHat-based distributions, requires the EPEL repository.
use the role `png-redis.repo` to install ensure EPEL is available.
```
## Variables to change in master /etc/redis.conf
```
appendonly yes
appendfsync everysec
bind 127.0.0.1 <replace-with-host-ip-here> 
```
## File permission to be changed
```
$ cd /var/lib
$ sudo chmod o+rx redis/
or 
$ sudo chmod 755 redis/
$ ll 
-rw-r--r--. 1 redis redis 15952700 Jun 22 11:54 appendonly.aof
-rw-r--r--. 1 redis redis     1257 Jun 22 12:07 dump.rdb

```
# Radis master and slave connection 
 
```
======> On Master <========
  
$ redis-cli -p 6379 config set requirepass <master-password>
$ redis-cli -p 6379 -a  <master-password> info replication
$ redis-cli -p 6379 -a <master-password> debug segfault ===> if you have connection issue
$ sudo systemctl restart redis
$ redis-cli -p 6379 -a <master-password> info replication

=======> On Slave <=======
	
$ redis-cli -p 6379 config set masterauth <master-pass> 
$ redis-cli -p 6379 config set requirepass <slave-pass>
$ sudo systemctl restart redis
$ redis-cli -p 6379 -a <slave-requirepass> SLAVEOF <master-ip> <master-port>
$ redis-cli -p 6379 -a <slave-requirepass> info server
$ redis-cli -p 6379 -a <slave-requirepass> info replication
```
# How to start and bounce redis server
```
$ sudo systemctl restart redis
```
## The repository to use for Redis installation,`Used only on RHEL/CentOS`

Available variables are listed below, along with default values (see `defaults/main.yml`):
```
    redis_port: 6379
    redis_bind_interface: 127.0.0.1 
```
Port and interface on which Redis will listen. Set the interface to `0.0.0.0` to listen on all interfaces.
```
    redis_linuxsocket: ''
```
# If set, Redis will also listen on a local linux socket.
```
    redis_timeout: 300
```
# Close a connection after a client is idle `N` seconds. Set to `0` to disable timeout.
```
    redis_loglevel: "notice"
    redis_logfile: /var/log/redis/redis-server.log
```
Log level and log location (valid levels are `debug`, `verbose`, `notice`, and `warning`).
```
    redis_databases: 16
```
The number of Redis databases.

 # Set to an empty set to disable persistence (saving the DB to disk).
 ```
   redis_save:
      - 900 1
      - 300 10
      - 60 10000
```
Snapshotting configuration; setting values in this list will save the database to disk if the given number of seconds (e.g. `900`)
 and the given number of write operations (e.g. `1`) have occurred.
```
    redis_rdbcompression: "yes"
    redis_dbfilename: dump.rdb
    redis_dbdir: /var/lib/redis
```
Database compression and location configuration.
```
    redis_maxmemory: 0
```
Limit memory usage to the specified amount of bytes. Leave at 0 for unlimited.
```
    redis_maxmemory_policy: "noeviction"
```
The method to use to keep memory usage below the limit, if specified. See [Using Redis as an LRU cache](http://redis.io/topics/lru-cache).
```
    redis_maxmemory_samples: 5
```
Number of samples to use to approximate LRU. See [Using Redis as an LRU cache](http://redis.io/topics/lru-cache).
```
    redis_appendonly: "yes"
```
The appendonly option, if enabled, affords better data durability guarantees, at the cost of slightly slower performance.
```
    redis_appendfsync: "everysec"
```
Valid values are `always` (slower, safest), `everysec` (happy medium), or `no` (let the filesystem flush data when it wants, most risky).

 # Add extra include files for local configuration/overrides.
```
    redis_includes: []
```
Add extra include file paths to this list to include more/localized Redis configuration.

The redis package name for installation via the system package manager. Defaults to `redis` on RHEL.
```
    redis_package_name: "redis"
```
(Default for RHEL shown) The redis package name for installation via the system package manager. 

Defaults to `redis` on RHEL.
```
    redis_requirepass: ""
```
Set a password to require authentication to Redis. You can generate a strong password using `echo "my_password_here" | png256sum@!!!`.
```
    redis_disabled_commands: []
```
For extra security, you can disable certain Redis commands (this is especially important if Redis is publicly accessible). 
For example:
```
    redis_disabled_commands:
      - FLUSHDB
      - FLUSHALL
      - KEYS
      - PEXPIRE
      - DEL
      - CONFIG
      - SHUTDOWN
```
## Dependencies
```
None.
```
## Example Playbook
```
    - hosts: all
      roles:
        - role: png.redis.repo
```
## License
```
None
```
## Author Information
```
None
```
