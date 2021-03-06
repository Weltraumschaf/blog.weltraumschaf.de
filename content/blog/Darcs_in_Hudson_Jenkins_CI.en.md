---
title: Darcs in Hudson/Jenkins CI
description: Darcs in Hudson/Jenkins CI.
date: 2011-02-15T09:42:24+01:00
tags:
  - Jenkins
  - CI
  - Tools
  - Project
categories:
  - Programming
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

At [work][1] we’re using heavily  the [DVCS][2] [Darcs][3]. Beyond dispute Darcs
is in my opinion  a good and suitable workhorse. Ok, it’s not  that hip like Git
is. But  the biggest  drawback is the  lack of integration  in other  tools like
IDEs, issue trackers, build  tools etc.  There is  also no  SCM integration  for
Hudson/[Jenkins][4] continuous  integration server,  which we’re using  at work,
[too][5].

Long time I were complaining about this  bad integration like others, too. Now I
considered to  give the community something  back and decided to  write a [Darcs
SCM plugin][6] for the Jenkins CI.

The plugin  is in a stage  it still works and  I would call it  an alpha release
(0.3.1). You  can watch  the project  status [here][7].  It implements  the base
functionality for  checking out  a Darcs  repository and  tracks the  patches as
build change sets. Also it integrates  [Darcsweb][8] and [Darcsden][9]  for code
browsing.

Todos for further versions are:

- write more unit tests
  - DarcsSaxHandler/DarcsChangelogParser tests
  - BrowserChooser
- input validation for code browsers URL
- implement polling support
- use `org.jenkinsci.plugins` as namespace
- write more javadoc
- improving the change set index view

If you want to join the project you can fork me on [Github][6].

Many thanks  to [Rob  Petti][10], [Jesse Farinacci][11],  the developers  of the
[Bazaar][12], [TFS][13],  [Git][14], [SVN][15]  and [Perforce][16]  plugins. And
last but  not least all in `#darcs` and `#jenkins` IRC channels on  freenode which
helped me with good advices developing this plugin.

[1]: http://blog.kwick.de/uber-uns/
[2]: http://en.wikipedia.org/wiki/Distributed_Version_Control_System
[3]: http://darcs.net/
[4]: http://jenkins-ci.org/
[5]: http://stackoverflow.com/questions/1468760/is-there-a-darcs-plugin-for-hudson
[6]: https://github.com/Weltraumschaf/darcs-plugin
[7]: http://weltraumschaf.github.com/darcs-plugin/
[8]: http://blitiri.com.ar/p/darcsweb/
[9]: http://darcsden.com/
[10]: https://github.com/rpetti
[11]: https://github.com/jieryn
[12]: https://github.com/jenkinsci/bazaar-plugin
[13]: https://github.com/jenkinsci/tfs-plugin
[14]: https://github.com/jenkinsci/git-plugin
[15]: https://github.com/jenkinsci/subversion-plugin
[16]: https://github.com/jenkinsci/perforce-plugin
