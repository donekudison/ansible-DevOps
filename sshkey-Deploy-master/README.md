Ansible Script for SSH Key Deploy
=================================

Description
===========
Script to deploy SSH Keys with ansible. This script uses "SSH Key Deploy" from
	https://github.com/KaiserSoft/SSH-Key-Deploy

This ansible role may download the latest version of the SSH-Key-Deploy script if you 
set the following variable to "True"

ssh_keys_update: True


Examples
========

- Deploy the SSH Keys onto a fresh host. One where your own key is not in authorized_keys yet    
$ ansible-playbook -i hosts ssh-deploy.yml --ask-pass

- Deploy the SSH Keys onto a host where you already have ssh key access    
$ ansible-playbook -i hosts ssh-deploy.yml

