---
title: Only SSL access to my blog
description: Only SSL access to my blog.
date: 2011-12-30T09:42:24+01:00
tags:
  - SSL
  - TLS
  - Blog
categories:
  - Security
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

Some time ago I  configured my blog to serve both HTTP and  HTTPS. From now on I
will redirect all  non-SSL requests permanently to HTTPS. The  reason is that no
one  access  the login  page  without  SSL by  accident.  If  you encounter  any
problems please let me know.

Unless you  have installed  the [CAcert][1] root  certificates in  your browser,
you  will become  a  warning  about my  server’s  certificate.  To prevent  this
install the root certificates from [here][2].

[1]: http://www.cacert.org/
[2]: http://www.cacert.org/index.php?id=3
