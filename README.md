These ansible roles are used to install necessary software and perform configuration on a fresh Debian installation.
The goal is to make reinstalling my Operating System less annoying.

**NOTE:** These roles expect to be invoked on localhost as the desired everyday user intended to be used. They will use the env vars `USER` and `HOME` to determine the correct username and home dir when needed. Do not run as root. 


```
ansible-playbook  PLAYBOOK_NAME --ask-become-pass -i inventory.yaml
```

The wrapper script abbreviates this invocation for various playbooks
```
./wrapper.sh repos
```

To set up a newly installed operating system, run `initial_install.sh`
