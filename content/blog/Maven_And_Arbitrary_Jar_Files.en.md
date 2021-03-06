---
title: Maven And Arbitrary Jar Files
description: Maven And Arbitrary Jar Files.
date: 2012-01-04T09:42:24+01:00
tags:
  - Java
  - Maven
  - Tools
categories:
  - Programming
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

Since  I’m  coding  sometimes  with  Java   I  also  use  [Maven][1]  to  manage
dependencies. It  is a  very easy  and straight forward  approach to  use Maven.
Also very nice that [Netbeans][2] just opens  a POM file. No need to configure a
project or such.

But  now I  was confronted  with the  need to  include a  library which  is only
available as stand alone jar file. The  solution is to install the jar file into
your local Maven repository as described [here][3].

[1]: http://maven.apache.org/
[2]: http://netbeans.org/
[3]: http://www.zparacha.com/include-externaljar-file-in-maven/
