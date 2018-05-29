Ansible Script for SSH Key Deploy
=================================
This ansible role may download the latest version of the SSH-Key-Deploy script if you 
set the following variable to "True"

ssh_keys_update: True


Examples
========

- Deploy the SSH Keys onto a fresh host. One where your own key is not in authorized_keys yet    
$ ansible-playbook -i inventory ssh-deploy.yml --ask-pass

- Deploy the SSH Keys onto a host where you already have ssh key access    
$ ansible-playbook -i inventory ssh-deploy.yml

