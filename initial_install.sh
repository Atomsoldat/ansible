#!/bin/bash

###
### This script should be run as a regular user, all tasks requiring root permissions will
### use "become: true". Some tasks e.g. during the installation of homebrew
### should be run as a regular user, they will fail when run as root
###

set -euo pipefail


# set up debian testing repos
# as well as all other repos we need
./wrapper.sh repos

sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get autoremove

# install all desired software
./wrapper.sh software

./wrapper.sh scripts

./wrapper.sh config

./wrapper.sh fonts
./wrapper.sh shares
./wrapper.sh home

