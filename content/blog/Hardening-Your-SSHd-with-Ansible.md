---
title: "Hardening Your SSHd With Ansible"
date: 2020-05-04T09:24:28+02:00
lastmod: 2020-05-04T09:24:28+02:00
tags:
  - SSH
  - SSHd
  - Ansible
  - hardening
categories:
  - Security
imgs: []
cover: ""  # image show on top
toc: true
comments: false
justify: false  # text-align: justify;
single: false  # display as a single page, hide navigation on bottom, like as about page.
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
draft: true
---

Whenever you run a server in the wild wild web you should harden your SSHd setup. If you wonder why you should do that, then spin up a machine with enabled SSHd and watch the logs: Usually it takes only few minutes until the first scans and brute force attacks come up in the logs. The internet is completely mapped. Not only IPv4 also IPv6. to scan the whole IPv6 address space is feasable with some bandwidth. Just look at [Shodan](https://www.shodan.io/).

### What I Use to Harden SSHd

1. Change the TCP port SSHd listens: This detains the most script kiddies or basic scans.
2. Install [fail2ban](https://www.fail2ban.org/): This wards you from brute force or dictionary attacks.
3. Configure SSHd right.

### What are

- fail2ban
- <https://infosec.mozilla.org/guidelines/openssh.html>

### fail2ban Jail Configuration

```ini
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
```

### Complete Play

```yaml
- name: Install fail2ban
  apt:
    name: fail2ban
    state: latest

- name: Copy fail2ban configuration
  copy:
    src: jail.conf
    # User config need to be named .local.
    dest: /etc/fail2ban/jail.local
  notify: Restart fail2ban

- name: Set SSH KexAlgorithms
  lineinfile:
    path: /etc/ssh/sshd_config
    state: present
    line: 'KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256'

- name: Set SSH Ciphers
  lineinfile:
    path: /etc/ssh/sshd_config
    state: present
    line: 'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr'

- name: Set SSH MACs
  lineinfile:
    path: /etc/ssh/sshd_config
    state: present
    line: 'MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com'

- name: Set SSH loglevel to verbose
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^#LogLevel INFO'
    line: 'LogLevel VERBOSE'

- name: Set log sftp level file access
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^Subsystem\s+sftp\s+/usr/lib/openssh/sftp-server'
    line: 'Subsystem sftp /usr/lib/openssh/sftp-server -f AUTHPRIV -l INFO'

- name: Disable SSH root login
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^#PermitRootLogin'
    line: 'PermitRootLogin no'

- name: Disable SSH password authentication
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^#PasswordAuthentication yes'
    line: 'PasswordAuthentication no'

- name: Set SSH UsePrivilegeSeparation
  lineinfile:
    path: /etc/ssh/sshd_config
    state: present
    line: 'UsePrivilegeSeparation sandbox'

- name: Set SSH AuthenticationMethods
  lineinfile:
    path: /etc/ssh/sshd_config
    state: present
    line: 'AuthenticationMethods publickey'

- name: Setup alternate SSHd port
  lineinfile:
    dest: /etc/ssh/sshd_config
    regexp: '^#Port'
    line: 'Port {{ ssh_hardening_port }}'

- name: Disable SSH short modulis for DH
  shell: |-
    awk '$5 >= 3071' /etc/ssh/moduli > /tmp/moduli &&
    mv /tmp/moduli /etc/ssh/moduli
  notify: Restart SSHd

- name: Delete authorized_keys of root
  file:
    path: /root/.ssh/authorized_keys
    force: yes
    state: absent
```