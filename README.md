These roles and playbooks are  currently written for a fresh `debian 12` installation with `XFCE4`.

The ansible version in Debian is ancient, use the ubuntu repo instead.


```
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible

```

```
ansible-playbook  playbook_computer_setup.yaml --ask-become-pass -e 'host_type=desktop'
ansible-playbook  playbook_computer_setup.yaml --ask-become-pass -e 'host_type=laptop'
```

The roles use `ansible_env.PWD` to find files. Hence, any playbook must be executed from the topmost directory. `host_type` must be set to the correct value so the respective group vars are included
