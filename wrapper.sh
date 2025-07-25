#!/bin/bash

arg=$1

case $arg in
	repos)
		ansible-playbook  playbooks/playbook_repo_setup.yaml --ask-become-pass  -i inventory.yaml
	;;
	software)
		ansible-playbook  playbooks/playbook_software_installation.yaml --ask-become-pass  -i inventory.yaml
	;;
	scripts)
		ansible-playbook  ./playbooks/playbook_script_installation.yaml --ask-become-pass -i inventory.yaml
	;;
	config)
		ansible-playbook  playbooks/playbook_config.yaml --ask-become-pass -i inventory.yaml
	;;
	shares)
		ansible-playbook  playbooks/playbook_nas_client.yaml --ask-become-pass -i inventory.yaml
	;;
	fonts)
		ansible-playbook  playbooks/playbook_fonts.yaml --ask-become-pass -i inventory.yaml
	;;
	home)
		echo "INFO: Note, that the homedir_setup role needs a valid SSH key in the ssh-agent"
		ansible-playbook  playbooks/playbook_homedir_setup.yaml --ask-become-pass -i inventory.yaml
	;;
esac

