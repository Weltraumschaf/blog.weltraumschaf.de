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

When you do some "login stuff" nowadays you may stumble upon the terms AuthN and AuthZ. Maybe you have wondered what the letters "N" and "Z" mean? The short answer:

- *AuthN* stands for *Authentication*, and
- *AuthZ* stands for *Authorization*.

That's easy right? I guess we're done for this blog post 🙃

## Authentication vs. Authorization

But what is the difference between these two terms? Are they not the same? The short answer: No, they aren’t!

### Authentication

*Authentication* is all about who you are.A simple example is when you type a username and password somewhere. A more complex scenario would be when you buy a TLS certificate or when you go to a notary to show your identity card.

So, *authentication* is the process of verifying that you are the person you are claiming to be.

### Authorization

*Authorization* is all about what you are allowed to do. A simple example would be that you are allowed to clone a Git repository and push into it, but you are not *authorized* to delete branches in that repository. *Authorization* must be granted by an entity which has more rights (is privileged) than you. For example, when you want to buy a new laptop you ask  your boss and she authorizes this by granting or declining your request.

So, *authorization* is the process of verifying what you are allowed to do.

## Final Words

*Authentication* can be used without *authorization* but vice versa is not possible. To *authorize* someone or something – not only natural persons may be *authenticated* or *authorized*, but also entities like computers, servers, APIs, etc. – it is required to first *authenticate* first in order to know who you can grant or decline access to (*authorize*). For example, when you walk around in a large factory there may be *restricted areas* with a security guard protecting it. You must show him your corporate identity card for *authentication*. Then the guard looks up in some system if you are allowed to access that area (*authorization*) and grants or declines you entry.

**UPDATE** In the article above, I wrote that you can't do *authorization* without *authentication*. On further reflection, I think that may not be completely true. This may actually be feasible with some [zero knowledge](https://en.wikipedia.org/wiki/Zero_knowledge) protocols, but this is a topic I need to look into further.

Cover image by [Zachary Lisko](https://unsplash.com/@liskozac) from [Unsplash](https://unsplash.com/).
