## Ansible Role to install 3rd party Webtatic Repository

The Webtatic Yum repository is a CentOS/RHEL repository containing updated web-related packages.

## Description: [Webtatic](https://webtatic.com/projects/yum-repository/) repo for RHEL/CentOS

## Platforms:
```
- name: EL
  versions:
      - 6
      - 7
```
## Requirements
Make sure you are running this on RHEL/CentOS

## How to use
* Include `webtatic.repo-epel` in your webtatic-play.yml

## Install the role by running 
```
$ ansible-playbook -i inventory /webtatic.epel-install/test-play.yml

```
## Example Playbook
```
- hosts: all
  roles: 
    - png.repo-webtatic
```
## License
None
