---
title: "Interim Move to Jekyll and GitHub"
description: "Interim Move to Jekyll and GitHub."
date: 2018-02-16T09:44:06+01:00
tags: ["Blog", "Jekyll", "GitHub"]
categories: ["Blog"]
authors: "Sven Strittmatter"
---

Roundabout two years  ago I decided to  get rid of Wordpress and  the full stack
of PHP and  MySQL. About my reasons  for this  decision I've blogged  here. As a
result I decided  to write my own simple blog  solution: [Uberblog][1]. This was
a weekend  project which served  me well, until I  decided to reinstall  my root
server from  scratch. Then the  hassle with  Ruby, Gems and  dependency versions
started. It was so much fiddling to  get these quite simple Ruby scripts running
again with their dependencies. It was the same  pain I had years of my live with
PHP and  Pear. I also had  these type of  setup problems recently with  Perl and
it's CPAN. I don't want to  bash these languages and dependency management tools
to much. But they are not really  convenient. You need to have special knowledge
and you  have to  dig deep inside  to get  it up and  running in a  reliable way.
That's a problem if you only want  to hack together some scripts, and then years
later  you need  to reinstall  them. So  I decided  to rewrite  Uberblog with  a
language which  compiles into a self conatined binary. So a enduser  who want to
use  the tool  do  not need  to  tinker around  with an  environment  he is  not
familiar with.

My choice  was Java.  Why? Because  you can  build a  final JAR  file containing
everything.  There is  no need  to  install anything  else  than a  JVM on  your
machine. And these JVMs are available  for almost all platforms. And also strong
argument for me: I  work as a Java developer since some years,  so it would be a
good practice. Alas I'm not finished with  that project. I took me more time and
effort than  expected. So  that's the reason  why I decided  to give  Jekyll and
GitHub a try as interim solution until I've finished my own solution.

[1]:  https://github.com/Weltraumschaf/uberblog