---
title: Debian and the Outdated Ruby Gems
description: Debian and the outdated Ruby Gems.
date: 2012-03-23T09:42:24+01:00
tags:
  - Debian
  - Ruby
  - Gems
  - Project
categories:
  - Programming
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

[Debian][1] is in  my personal opinion the best Linux  server distribution ever!
I've never used something  else. But one big drawback is that a  lot of stuff is
really outdated: With PHP you have to  use backports. Java and Maven brings some
hassle, too. And now I realized the same  problem with Ruby Gems. But there is a
solution as described [here][2] (german blog post).

By  default  Debian  disables  the `gem  update  --system`  to  prevent
circumventing  the Debian  packet management  system. If  you need  a newer  Gem
version you can install the [rubygems-update][3]:

```bash
$> sudo gem install rubygems-update --version=1.8.20
```

With  the  --version  option  you   can  chose  your  preferred  version.  After
installation you need to invoke the update command:

```bash
$> sudo update_rubygems
```

[1]: http://www.debian.org/
[2]: http://www.beier-christian.eu/blog/weblog/ruby-gem-update-is-disabled-on-debian/
[3]: http://rubygems.org/gems/rubygems-update
