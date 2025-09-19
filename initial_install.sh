#!/bin/bash

###
### This script should be run as a regular user, all tasks requiring root permissions will
### use "become: true". Some tasks e.g. during the installation of homebrew
### should be run as a regular user, they will fail when run as root
###

set -euo pipefail

echo "Enter sudo password to be used by ansible for privileged tasks"
read password

# set up debian testing repos
# as well as all other repos we need
ansible-playbook  playbooks/repo_setup.yaml --become-password-file <(printf "${password}")  -i inventory.yaml

sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get autoremove

# install all desired software
ansible-playbook  playbooks/software_installation.yaml --become-password-file <(printf "${password}")  -i inventory.yaml

ansible-playbook  playbooks/script_installation.yaml --become-password-file <(printf "${password}") -i inventory.yaml

ansible-playbook  playbooks/config.yaml --become-password-file <(printf "${password}") -i inventory.yaml

ansible-playbook  playbooks/fonts.yaml --become-password-file <(printf "${password}") -i inventory.yaml
ansible-playbook  playbooks/storage.yaml --become-password-file <(printf "${password}") -i inventory.yaml

echo "INFO: Note, that the homedir_setup role needs a valid SSH key in the ssh-agent"
ansible-playbook  playbooks/homedir_setup.yaml --become-password-file <(printf "${password}") -i inventory.yaml
