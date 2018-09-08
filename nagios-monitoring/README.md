LAMP Stack + Nagios: Ansible Playbook
-----------------------------------------------------------------------------

- Requires Ansible 1.2
- Expects CentOS/RHEL 7.x 

Here we'll install and configure [NAGIOS](https://www.nagios.org/downloads/nagios-core/) to monitor web server,load balancer, Database servers. 
It also can be used to a rolling update of a LAMP stack.

## Installing NSClient++ and  default ports
```
Protocol      Source  Source-port  Destination 	Dest-port  Comment
NRPE	      Nagios	None        client	  5666	  The nagios server initiates a call to the client on port 5666
NSClient      Nagios	None	    client	  12489	  The nagios server initiates a call to the client on port 12489
NSCA	      client	None	    Nagios	  5667	  The client initiates a call to the Nagios server on port 5667
NRPE-proxy    client	None	  remote-client   5666	  The client initiates a call to the remote client on port 5666
```

You can also optionally configure a [Nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/objectdefinitions.html#host) monitoring node.

## Initial Site Setup 

First we configure the entire stack by listing our hosts in the 'hosts'
inventory file, grouped by their purpose:

```
Examples:
		[webservers]
		webserver1
		webserver2
		
		[dbservers]
		dbserver
		
		[lbservers]
		lbserver
		
		[monitoring]
		nagios
```

## After which we execute the following command to deploy the site:
```
$ ansible-playbook -i inventory nagios-monitoring/test-play --sudo
```
The Nagios web interface can be reached at http://<ip-of-nagios>/nagios/

The default username and password are "nagiosadmin" / "nagiosadmin".

## Liences
```
None
```
## Author
```
PNG-None
```