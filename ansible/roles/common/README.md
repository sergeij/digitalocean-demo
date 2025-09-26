# common

Ansible role that applies system-wide common configuration to all nodes. This includes essential settings and packages needed across all infrastructure.

Currently, this role performs the following:
- Configures the system timezone
- Sets the hostname
- Installs common system packages 

## Requirements

- Ansible [core 2.17.12] or newer
- Supported OS: Ubuntu 22.04 (or update as applicable)

## Example Playbook

Playbook example:

```yaml
    - hosts: all
      become: true
      gather_facts: true
      roles:
        - common
```

## Directory Structure

```sh
.
├── README.md
├── defaults
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   └── main.yml
└── vars
    └── main.yml
```

## Notes

- This role is designed to be idempotent and safe to run multiple times.
