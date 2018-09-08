MySQL Server
============

This roles helps to install MySQL Server across RHEL.
Apart from installing the MySQL Server, it applies basic hardening, like
securing the root account with password, and removing test databases. The role
can also be used to add databases to the MySQL server and create users in the
database. It also supports configuring the databases for replication--both
master and slave can be configured via this role.

##Steps to installs [MYSQL](https://dev.mysql.com/doc/mysql-repo-excerpt/8.0/en/linux-installation-yum-repo.html) on Centos/RHEL 7.x

Requirements
------------

This role requires Ansible 1.4 or higher, and platform requirements are listed
in the metadata file.

Role Variables
--------------

The variables that can be passed to this role and a brief description about
them are as follows:

      mysql_port: 3306                 # The port for mysql server to listen
      mysql_bind_address: "0.0.0.0"    # The bind address for mysql server
      mysql_root_db_pass: foobar       # The root DB password

      # A list that has all the databases to be
      # created and their replication status:
      mysql_db:                                 
           - name: foo-testing
             replicate: yes
           - name: bar
             replicate: no

      # A list of the mysql users to be created
      # and their password and privileges:
      mysql_users:                              
           - name: testing
             pass: foobar
             priv: "*.*:ALL"

      # If the database is replicated the users
      # to be used for replication:
      mysql_repl_user:                          
        - name: replslave
          pass: foobar

      # The role of this server in replication:
      mysql_repl_role: master

      # A unique id for the mysql server (used in replication):
      mysql_db_id: 7

Examples
--------

1) Install MySQL Server and set the root password, but don't create any
database or users.

      - hosts: all
        roles:
        - {role: mysql.install, mysql_root_db_pass: foobar, mysql_db: none, mysql_users: none }

2) Install MySQL Server and create 2 databases and 2 users.

      - hosts: all
        roles:
         - {role: mysql.intall, mysql_db: [{name: testing},
                                    {name: testing2}],
            mysql_users: [{name: pngdbuser1, pass: foobar, priv: "*.*:ALL"},
                          {name: pngdbuser2, pass: foo}] }

Note: If users are specified and password/privileges are not specified, then
default values are set.

3) Install MySQL Server and create 2 databases and 2 users and configure the
database as replication master with one database configured for replication.

      - hosts: all
        roles:
         - {role: mysql.install, mysql_db: [{name: testing1, replicate: yes },
                                    { name: testing2, replicate: no}], 
                         mysql_users: [{name: testing3, pass: foobar, priv: "*.*:ALL"},
                                       {name: testing2, pass: foo}],
                         mysql_repl_user: [{name: repl, pass: foobar}] }

4) A fully installed/configured MySQL Server with master and slave
replication.

      - hosts: master
        roles:
         - {role: mysql.install, mysql_db: [{name: testing1}, {name: testing2}],
                         mysql_users: [{name: testing3, pass: foobar, priv: "*.*:ALL"},
                                       {name: testing2, pass: foo}],
                         mysql_db_id: 8 }

      - hosts: slave
        roles:
         - {role: mysql.install, mysql_db: none, mysql_users: none,
                  mysql_repl_role: slave, mysql_repl_master: mastername,
                  mysql_db_id: 9, mysql_repl_user: [{name: repl, pass: foobar}] }

Note: When configuring the full replication please make sure the master is
configured via this role and the master is available in inventory and facts
have been gathered for master. The replication tasks assume the database is
new and has no data.


Dependencies
------------

None

License
-------

BSD
 

