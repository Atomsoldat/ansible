#!/bin/bash

arg=$1

case $arg in
	repos)
		ansible-playbook  playbooks/repo_setup.yaml --ask-become-pass  -i inventory.yaml
	;;
	software)
		ansible-playbook  playbooks/software_installation.yaml --ask-become-pass  -i inventory.yaml
	;;
	scripts)
		ansible-playbook  playbooks/script_installation.yaml --ask-become-pass -i inventory.yaml
	;;
	config)
		ansible-playbook  playbooks/config.yaml --ask-become-pass -i inventory.yaml
	;;
	shares)
		ansible-playbook  playbooks/nas_client.yaml --ask-become-pass -i inventory.yaml
	;;
	fonts)
		ansible-playbook  playbooks/fonts.yaml --ask-become-pass -i inventory.yaml
	;;
	home)
		echo "INFO: Note, that the homedir_setup role needs a valid SSH key in the ssh-agent"
		ansible-playbook  playbooks/homedir_setup.yaml --ask-become-pass -i inventory.yaml
	;;
esac

