

```
ansible-playbook  playbooks/desktop_setup.yaml --ask-become-pass -e 'host_type=desktop'
```

The roles use `ansible_env.PWD` to find files. Hence, any playbook must be executed from the topmost directory. `host_type` must be set to the correct value so the respective group vars are included
