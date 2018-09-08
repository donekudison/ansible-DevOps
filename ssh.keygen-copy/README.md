Ansible Script for SSH Key Deploy
=================================
Script to deploy SSH Keys with ansible. This script uses "sshkey Deploy"
This ansible role may download the latest version of the sshkey-Deploy script if you
set the following variable to "True"

ssh_keys_update: True


Examples
========

- Deploy the SSH Keys onto a fresh host. One where your own key is not in authorized_keys yet
$ ansible-playbook -i inventory ssh-deploy.yml --ask-pass or
$ ansible-playbook -i inventory sshkey-Deploy-master/ssh-deploy.yml --ask-pass

- Deploy the SSH Keys onto a host where you already have ssh key access
$ ansible-playbook -i inventory ssh-deploy.yml or
$ ansible-playbook -i inventory sshkey-Deploy-master/ssh-deploy.yml
