---
title: "Credential Stuffing vs Password Spraying"
date: 2020-10-29T11:16:08+01:00
lastmod: 2020-10-29T11:16:08+01:00
tags:
  - Attacks
  - Passwords
categories:
  - Security
imgs:
  - "Cover.jpg"
cover: "Cover.jpg"  # image show on top
toc: true
comments: false
justify: false  # text-align: justify;
single: false  # display as a single page, hide navigation on bottom, like as about page.
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

At my [employer](https://www.iteratec.com) we use Office 365. I'm not an Microsoft advocate. My friends and colleagues rather know me as Apple-Fanboy and BSD-Geek. But I have to admit that Office 365 works good enough. Even in these pandemic times when we work from home Teams and such serves very well.

As part of our security team we also encounter attacks against our user accounts. Maybe you read about that in the press: There are _credential stuffing_ and _password spray_ attacks going on this year against Office 365 accounts. Today I wondered what the concrete difference is between these two types of attacks. Until today I used the terms interchangeably: Its all a kind of brute force, right? No, it's not that easy.

## Credential Stuffing

This is an attack where an adversary uses a **known pair of username and password** to gain access. Eg. there is a password leak from the site foobar.com: They stored username and password in plain text. Lot of users use the same username password across many sites. So one could try to use the username and password from foobar.com at Facebook, Twitter or whatever to gain access.

So _credential stuffing_ uses a list of known username password combinations to brute-force against an authentication.

## Password Spraying

In contrast this is an attack where the adversary **only knows the username** and tries a list of [common or weak passwords](https://en.wikipedia.org/wiki/List_of_the_most_common_passwords) with it. Eg. you know that the usernames at foobar.com are same as the email addresses and you can harvest some of them from the website. Then you use a list of commonly used or weak password (eg. `test1234`, `password` etc.) together wit the usernames to gain access.

So _password spraying_ uses a list of known usernames in combination with commonly known and/or weak passwords to brute-force authentication.

First posted at <https://blog.weltraumschaf.de/blog/Credential-Stuffing-vs-Password-Spraying/>