---
title: Fuck Of Wordpress
description: Fuck Of Wordpress.
date: 2012-03-18T09:42:24+01:00
tags:
  - Wordpress
  - Blog
  - Ruby
  - Project
categories:
  - Programming
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

[Wordpress][1] was my first blog software.  I used it since roundabout six years
now.  Writing an  own plugin  for my  blog was  one of  my first  steps learning
[PHP][2]. After  my experiences with  Java 1.4 and MS  Visual C++ 6.0  from 2002
until 2005 I came over to the web  scripting area and got in touch with PHP. The
new OOP features and the short round trip time I liked.

But nowadays I realize that Wordpress  is extremely slow. I tried several tricks
and tweaks to  reduce the response time.  But it was impossible to  go under one
second  without jumping  through hoops.  I thought  about the  whole setup:  Why
should my blog render  the whole stuff on each request?  And the current version
of Wordpress  has a lot  bloated stuff to  do on each  request. So I  checked my
requirements:

- I blog not that often
- I only update typos
- I don't need WYSIWYG, editing [Markdown][3] files is comfortable enough
- I do not really need a comment feature

So  I decided  to use  something way  more simple  than the  known bloated  full
featured PHP  blogs out  in the  wild: I've written  a view  lines of  Ruby code
which generates  static HTML files  from Markdown  files. Each Markdown  file is
one blog  post. Added some HTML  and CSS and all  of that stored into  a [GitHub
Repo][4]. On the server  side there are only static files  served, a crontab job
pulls each  hour the Git  repo and runs the  publish script which  generates the
static content. Voila, here it is my ultra fast [Uberblog][4]!

[1]: http://wordpress.org/
[2]: http://php.net/
[3]: http://daringfireball.net/projects/markdown/
[4]: https://github.com/Weltraumschaf/uberblog
