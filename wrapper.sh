#!/bin/bash

arg=$1

case $arg in
	software)
		ansible-playbook  playbook_computer_setup.yaml --ask-become-pass -e 'host_type=desktop'
	;;
	shares)
		ansible-playbook  playbook_nas_client.yaml --ask-become-pass -e 'host_type=desktop'
	;;
esac

