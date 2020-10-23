---
title: "AuthN vs AuthZ"
date: 2020-10-23T10:24:18+02:00
lastmod: 2020-10-23T10:24:18+02:00
tags:
  - OAuth 2.0
  - Authentication
  - Authorization
categories:
  - Security
imgs:
  - "Cover.jpg"
cover: "Cover.jpg" # image show on top
toc: true
comments: false
justify: false  # text-align: justify;
single: false  # display as a single page, hide navigation on bottom, like as about page.
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

When you do some "login stuff" nowadays you may stumbled upon the  terms *AuthN* and *AuthZ*. Maybe you wondered what these "N" and "Z" means? Short answer:

- *AuthN*  stands for *Authentication*, and
- *AuthZ* stands for *Authorization*.

That's easy right? We're done for this blog post 🙃

## Authentication vs. Authorization

But what is the difference of these two terms? Is it not the same? Short answer: No, it isn't!

### Authentication

*Authentication* is all about who you are. In the most simple form when you type a username and password somewhere. In a more complex scenario – eg. when you buy a TLS certificate – when you go to a notary showing your identity card.

So *authentication* is the process of verify that you are the person you are pretending to be.

### Authorization

*Authorization* is all about what you are allowed to do. In the most simple form you are allowed to clone a Git repository and push into it, but you are not *authorized* to delete branches in that repository. *Authorization* must be granted by an entity which have more rights (is privileged) than you. Eg. when you want to buy a new laptop you request this to your boss and she authorizes this by granting or declining it.

So *authorization* is the process of verify what you are allowed to do.

## Last Words

*Authentication* can be used without *authorization* but vice versa is not possible. To *authorize* someone or something – not only natural persons may be *authenticated* or *authorized*, but also entities like computers, servers, APIs, etc. – it is required to *authenticate* first to know who you grant or decline access (*authorize*). Eg. when you walk around in a large factory there may be *restricted areas* with a security guard protecting it. You must show him your corporate identity card for *authentication*. Then the guard looks up in his system if you are allowed to access that ares (*authorization*) and grants or declines that you go on.

Cover image by [Zachary Lisko](https://unsplash.com/@liskozac) from [Unsplash](https://unsplash.com/).