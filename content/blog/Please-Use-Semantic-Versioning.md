---
title: "Please Use Semantic Versioning"
date: 2020-05-22T08:49:06+02:00
lastmod: 2020-05-22T08:49:06+02:00
tags: []
categories: []
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

**TL;DR** Please use [Semantic Versioning][1] and please use it right!

This is a little rant about tools, libs and frameworks not using [Semantic Versioning][1]. This morning I was triggered on Twitter by the announcement of [Terraform][2] version 0.13. My first thought was: WTF! Why are you still at 0.x with a software widely used in production? Disclaimer: I use Terraform by my self and I like it. Scrolling through my time line I saw various other announcements like 0.9 or 0.7.5 etc. for other things.

## So Here Is My Advice

**PLEASE USE SEMANTIC VERSIONING! ALWAYS!**

When you start a new project, then start with `1.0.0` and **NOT** with `0.0.1`! Some would say "But, but we are not feature complete and only if we are feature complete we may use the 1.0
!" I say wrong! There is no law stating that you must use 1.0 only when you are feature complete. In my experience software is never feature complete. So with this opinion you would never reach the 1.0.

## Why should I care about it

The one and only point about this is compatibility. Let me give you a short introduction into Semantic Versioning:

- You have three numbers separated by dots.
- The first number is the *major version*.
- The second number is the *minor version*.
- The third number is the *patch version*.

The *major version* **must be increased**, if you change your software in a way which is not backward compatible (also binary compatible) in any way. This means that others compiling against your software will see compile errors or files could not be read anymore due to format change etc. The *minor version* **must be increased**, if you add new features, but you are still backward compatible. And the *patch version* **must be increased**, if you only fix a bug, but in a backward compatible way. For details see the documentation of [Semantic Versioning][1].

So if you start with `0.x` how would you indicate a major breaking change? Ok, you could go to `1.0`, but then you can also start at `1.0.0` anyway. Lot of build tools like Maven, Cargo, npm etc. rely on these rules for automatic dependency updates. You want automatically new patch level versions in your build, but no major breaking changes. In the last few years I saw lot of colleagues wasting days in fixing builds because one does a major braking change in a minor or patch level version. More harmful when the build compiles but the behavior of the software changed in a subtle way and introduces logical bugs. Shame on you, if you release your software in that way because you waste lifetime of others!

[1]: https://semver.org/
[2]: https://www.terraform.io/
