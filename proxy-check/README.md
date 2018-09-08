# Ansible Role: HTTP_PROXY

Ansible role that check and disable proxy setting on:

* Centos/RHEL 7.x

## Dependencies

* None
  
## Example Playbook
```
    - hosts: all
      pre-tasks:
      tasks:
        
```
## How to run this playbook
```
$ ansible-playbook -i inventory proxy-check/test-unset.yml --sudo

```
## License

None