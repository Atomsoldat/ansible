#!/bin/bash

# This script should be run as a regular user,
# all tasks requiring root permissions will use "become: true"

set -euo pipefail

ansible-playbook  playbooks/essential_packages.yaml --ask-become-pass -i inventory.yaml
ansible-playbook  playbooks/repo_setup.yaml --ask-become-pass -i inventory.yaml

# set up debian testing repos
# as well as all other repos we need
ansible-playbook  playbooks/repo_setup.yaml --ask-become-pass -i inventory.yaml

source /etc/os-release

if [[ "$PRETTY_NAME" == "Debian" ]]; then
  sudo apt-get update && sudo apt-get dist-upgrade
  sudo apt-get autoremove
fi

ansible-playbook  playbooks/homedir_setup.yaml --ask-become-pass -i inventory.yaml

# install all desired software
ansible-playbook  playbooks/software_installation.yaml --ask-become-pass -i inventory.yaml

ansible-playbook  playbooks/script_installation.yaml --ask-become-pass -i inventory.yaml
ansible-playbook  playbooks/config.yaml --ask-become-pass -i inventory.yaml


ansible-playbook  playbooks/fonts.yaml --ask-become-pass -i inventory.yaml
