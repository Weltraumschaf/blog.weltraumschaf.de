---
title: What causes E_STRICT errors in PHP
description: What causes E_STRICT errors in PHP.
date: 2011-07-16T09:42:24+01:00
tags:
  - PHP
categories:
  - Programming
authors: Sven Strittmatter
---

Some months ago  this question came up on  my work. We asked our  self what kind
of  errors causes  an _E_STRICT_  error. The  naive approach  was to  search the
[php.net][1].  But  I  didn’t  find  anything about  that.  Yes  there  is  some
information what  number _E_STRICT_ has and  that it causes errors  if you don’t
satisfy the  strict standards and  it’s important  to be future  compatible. But
why? And what?

Then I thought: Ok, to implement  this feature (_E_STRICT_ standard) they needed
a list  for what they  will throw  an _E_STRICT_ error.  I asked Google.  What i
found was not  really helpful. Only a not exhaustive  list on [pear.php.net][2].
I wonder how they can implement something  such _E_STRICT_, if they don’t have a
list for that. Are they still hacking on without thinking about what to do?

So I gathered the  sparely information from the web and started  to grep the PHP
source  code.  So  I  can  present  a  hopefully  exhaustive  list  what  causes
_E_STRICT_ errors:

- when static methods are declared as abstract
- when non-static methods are called static
- when a static property is accessed dynamically
- when assigning new with reference

    $foo =& new Foo();

- if you use `is_a()` instead of `instanceof` (in 5.2, in 5.3 undeprecated&hellip;)
- if you use var instead of `private`/`protected`/`public` for class properties
- if method declaration/signature of overridden methods differ
- if you declare both the PHP4 and PHP5 constructor in a class
- if you use “Automagic Objects”

    $notInitializedYet->foo = 'bar';

- if you assign function/method return values as reference

    $foo =& bar();

- if you pass function/method return values as reference to a function/method

    foo(bar()); //if function foo(&$aReference { &hellip; }

- if resources are casted implicit to an integer

    $row[$query_id] = mysql_fetch_array($query_id);
    // if get_type($query_id) == 'resource'

- if `mktime()` is called without parameter. You should use `time()` instead
- if you call `mysqli_next_result()`/`mysqli::next_result()` although there are
  no further results. You should test with `mysqli_more_results()`/`mysqli::more_results()` before
- and last but not least: If you don’t set a default timezone (neither in Code nor in php.ini)

[1]: http://php.net/
[2]: http://pear.php.net/