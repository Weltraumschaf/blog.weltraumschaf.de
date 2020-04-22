---
title: Post to Twitter with Ruby
description: Post to Twitter with Ruby.
date: 2012-03-23T09:42:24+01:00
tags:
  - Twitter
  - API
  - Ruby
categories: Programming
authors: Sven Strittmatter
---

Just few  hours ago I  added the feature  that new blog  posts are posted  to my
[Twitter  account][1]. With  the  [twitter  gem][2] only  a  few  lines of  code
necessary:

```ruby
require 'twitter'

twitter = Twitter.new({
    :consumer_key       => 'YOUR_CONSUMER_KEY',
    :consumer_secret    => 'YOUR_CONSUMER_SECRET',
    :oauth_token        => 'YOUR_OAUTH_TOKEN',
    :oauth_token_secret => 'YOUR_OAUTH_TOKEN_SECRET'
})
twitter.update('Hello world!')
```

Shorten URIs with [bitly gem][3] is as simple as posting to twitter, too:

```ruby
require 'bitly'

Bitly.use_api_version_3
bitly = Bitly.new('YOUR_USERNAME', 'YOUR_API_KEY')
short_url = bitly.shorten(longUrl).short_url
```

[1]: https://twitter.com/Weltraumschaf/
[2]: http://twitter.rubyforge.org/
[3]: https://github.com/philnash/bitly
