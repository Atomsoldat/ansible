These ansible roles are used to install necessary software and perform configuration on a fresh Debian installation.
The goal is to make reinstalling my Operating System less annoying.


```
ansible-playbook  PLAYBOOK_NAME --ask-become-pass -i inventory.yaml
```

The wrapper script abbreviates this invocation for various playbooks
```
./wrapper.sh repos
```

To set up a newly installed operating system, run `initial_install.sh`
