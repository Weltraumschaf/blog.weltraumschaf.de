---
title: "Hardening Your SSHd With Ansible"
date: 2020-05-08T10:12:37+02:00
lastmod: 2020-05-08T10:12:37+02:00
tags:
  - SSH
  - SSHd
  - Ansible
  - hardening
categories:
  - Security
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
draft: true
---

**Disclaimer**: This is not a beginner tutorial. You should have a brief understanding and some experiences with Linux and [Ansible][ansible].

Whenever you run a server in the wild wild web you should harden your SSHd setup. If you wonder why you should do that, then spin up a machine with enabled SSHd and watch the logs: Usually it takes only few minutes until the first scans and brute force attacks showing up in the logs. The internet is completely mapped. Not only IPv4 also IPv6. Scanning the whole IPv6 address space is feasible with some bandwidth. Just look at [Shodan][shodan].

What I do to harden SSHd on my machines:

1. Change the TCP port SSHd listens: This detains the most script kiddies or basic scans.
2. Install [fail2ban][fail2ban]: This wards you from brute force or dictionary attacks.
3. Configure SSHd right.

All the examples in this post are based on [Debian Buster][debian] and [Ansible][ansible] 2.9.

## Change the TCP Port

This is a dead simple advice and I do this since ages. It is quite obvious that SSHd listening on default port 22 is an easy target and it is no thrill to change this to any other number. Obviously you should not use a port number used for other services. If you are paranoid you can set a different port on each host. To change the port simply change the `Port` directive in `/etc/ssh/sshd_config`. As a Ansible task this looks like:

```yaml
- name: Setup alternate SSHd port
  lineinfile:
    dest: /etc/ssh/sshd_config
    regexp: '^#Port'
    line: 'Port 4242'
```

To use a different non-standard port for SSH in Ansible you just need to set the `ansible_port` variable in your inventory, eg. same for all hosts:

```ini
[all]
host1.foobar.com
host2.foobar.com
...
[all:vars]
ansible_port="4242"
```

or different port for each host:

```ini
[all]
host1.foobar.com ansible_port="4243"
host2.foobar.com ansible_port="4242"
...
```

### Drawback of Changing the Port

There is one major drawback of this practice: You change the port during your Ansible play which will cause connection errors. I guess there are ways to change the port and reconnect during a play, but the most common approach is to split your plays. What I suggest is to make a simple "init" playbook which contains the SSH hardening stuff. Then you execute this playbook on a fresh machine with default port for SSH. After that you execute your other playbooks as usual.

This approach implies that you run your "init" playbook not via your inventory because this has changed SSH ports or you must overwrite this variable. I do the latter:

```bash
> ansible-playbook \
    --limit host1.foobar.com \
    init.yml \
    -e "ansible_ssh_port=22"
```

## fail2ban Jail Configuration

Next step is to install and configure [fail2ban][fail2ban]. This is a simple tool which refuses further connections on detection of brute force. It comes with a large example configuration located at `/etc/fail2ban/jail.conf` with lot of explanatory comments. One important point is that you must place your custom configuration at `/etc/fail2ban/jail.local`. Editing the default file will have no effect. And then configure the SSH daemon:

```ini
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
```

This example shows the default which are sufficient for the most cases. The only import part is the `enabled = true` option and restart the daemon: `systemctl restart fail2ban.service`. Now a user have maximum five tries to login to SSH before he get banned for ten minutes. Of course you can tweak these settings in the`jail.local` according to your paranoia level.

## Recommended Settings for OpenSSH

Mozilla has a very good and comprehensive list of settings you should use for your SSHd in their [infosec guidelines](https://infosec.mozilla.org/guidelines/openssh.html). I won't go into the details here because it makes no sense to just copy the content from Mozilla. You can read it over there by yourself. I'll only highlight the IMHO most important settings:

* `PermitRootLogin`: This should be `no` . Not only for auditing reasons as documented in the guideline. This name is easy to guess. so my advise is to use a random name like "slartibartfass" or such to exacerbate brute force attacks.
* `AuthenticationMethods`: Only use key based authentication! No excuse! Protect your keys with a passphrase! No excuse! Use at least 4029 bits with RSA! Also no excuse!
* Do not use weak ciphers. The guideline tell you which ones to use.

And last but not least: **Use the latest version** of OpenSSH!

## The Ansible Playbook

And here comes the palybook with some inline comments:

```yaml
- name: Install fail2ban
  apt:
    name: fail2ban
    state: latest

# Here you need your confguration. In my case I just copied the default
# from /etc/fail2ban/jail.conf and enabled sshd as described above
- name: Copy fail2ban configuration
  copy:
    src: jail.conf
    dest: /etc/fail2ban/jail.local

- name: Restart fail2ban
  service:
    name: fail2ban
    state: restarted

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

# Here you should use your custom port!
- name: Setup alternate SSHd port
  lineinfile:
    dest: /etc/ssh/sshd_config
    regexp: '^#Port'
    line: 'Port 4242'

- name: Disable SSH short modulis for DH
  shell: |-
    awk '$5 >= 3071' /etc/ssh/moduli > /tmp/moduli &&
    mv /tmp/moduli /etc/ssh/moduli

- name: Restart SSHd
  service:
    name: sshd
    state: restarted
```

I hope this helps you setting up a more secure server in the internet 😊

[ansible]:  https://www.ansible.com/
[debian]:   https://www.debian.org/releases/stable/index.de.html
[fail2ban]: https://www.fail2ban.org/
[shodan]:   https://www.shodan.io/
