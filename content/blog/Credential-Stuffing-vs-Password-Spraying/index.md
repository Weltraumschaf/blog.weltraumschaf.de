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

We use Office 365 in a regular basis in my [company](https://www.iteratec.com). Don’t get me wrong – I’m hardly what you’d call a Microsoft advocate. In fact, my friends and colleagues know me rather as an Apple-fanboy and BSD-Geek. But I have to admit that Office 365 works pretty well. And, in these pandemic times when we work from home, Teams and other MS products come in very handy.

As part of my company’s security team we also encounter attacks against our user accounts. Perhaps you have read about such incidents in the press: Normally these reports concern _credential stuffing_ and _password spray_ attacks directed at Office 365 accounts. Today, I sat down and wondered what exactly the difference was between these two types of attacks. Until now I had used the terms pretty interchangeably: They are both a kind of brute force attack, right? Actually, it’s not that simple.

## Credential Stuffing

This is an attack where an adversary uses a **known pair of username and password** to gain access. For example, there is a password leak from the site foobar.com: They stored the username and password in plain text. Lot of users use the same username and password across many sites. So, one could try to use the username and password from foobar.com on Facebook, Twitter or whatever to gain access.

Therefore _credential stuffing_ uses a list of known username password combinations to brute-force against an authentication.

## Password Spraying

In contrast to the above, this is an attack where the adversary **only knows the username** and tries a list of [common or weak passwords](https://en.wikipedia.org/wiki/List_of_the_most_common_passwords) with it. E.g. you know that the usernames at foobar.com are the same as the email addresses and you can harvest some of them from the website. Then you use a list of commonly used or weak passwords (e.g. `test1234`, `password` etc.) together with the usernames to gain access.

So, _password spraying_ uses a list of known usernames in combination with commonly known and/or weak passwords to brute-force authentication.

Cover image by [Methi SOMÇAĞ](https://unsplash.com/@methi_somcag) from [Unsplash](https://unsplash.com/).
