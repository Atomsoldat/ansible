#!/bin/bash

###
### This script should be run as a regular user, all tasks requiring root permissions will
### use "become: true". Some tasks e.g. during the installation of homebrew
### should be run as a regular user, they will fail when run as root
###

set -euo pipefail

ansible_password_file="${HOME}/.ansible_becomepass_temp"

touch ${ansible_password_file}
chmod go-rwx ${ansible_password_file}

function cleanup {
    rm ${ansible_password_file}
}

trap cleanup EXIT


echo "Enter sudo password to be used by ansible for privileged tasks"
# set empty IFS so read will read until the newline
IFS= read -sr password

echo ${password} > $ansible_password_file

eval $(ssh-agent)
ssh-add


# set up debian testing repos
# as well as all other repos we need
ansible-playbook  playbooks/repo_setup.yaml --become-password-file ${ansible_password_file}  -i inventory.yaml

sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get autoremove

# install all desired software
ansible-playbook  playbooks/software_installation.yaml --become-password-file ${ansible_password_file}  -i inventory.yaml

ansible-playbook  playbooks/script_installation.yaml --become-password-file ${ansible_password_file} -i inventory.yaml

ansible-playbook  playbooks/config.yaml --become-password-file ${ansible_password_file} -i inventory.yaml

ansible-playbook  playbooks/fonts.yaml --become-password-file ${ansible_password_file} -i inventory.yaml
ansible-playbook  playbooks/storage.yaml --become-password-file ${ansible_password_file} -i inventory.yaml

echo "INFO: Note, that the homedir_setup role needs a valid SSH key in the ssh-agent"
ansible-playbook  playbooks/homedir_setup.yaml --become-password-file ${ansible_password_file} -i inventory.yaml
