---
title: "Hide and Seek in TXT Records"
date: 2020-09-18T13:27:01+02:00
lastmod: 2020-09-18T13:27:01+02:00
tags:
  - malware
  - dns
  - obfuscation
  - payloads
categories:
  - security
imgs: []
cover: ""  # image show on top
toc: true
comments: false
justify: false  # text-align: justify;
single: false  # display as a single page, hide navigation on bottom, like as about page.
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

Did you ever wondered how the "bad guys" cover things?

Some time ago [John Ferrell][hiding-1] wrote about how to hide malicious code in files looking like a good old plain text log file. Last month (August 2020) John Hammond wrote a [part two][hiding-2]. In this part he's showing how they download additional payloads from the internet under the radar. It's quite simple, if you know.

## What's the Problem with Payloads

So if you are writing malware you face the same problem as any software developer: You want to ship updates. But it is not that simple. If you register a domain to provide your payload it is way to easy to block this domain as a counter measure. What if you could use a domain which no one can easily block? Here comes [Googles DNS service][google-dns] into the play. Most of you know Google's DNS from the famous `8.8.8.8`, but they also provide a HTTPS based interface:

```text
curl -sS 'https://dns.google.com/resolve?name=weltraumschaf.de
```

Which will respond with:

```json
{
  "Status": 0,
  "TC": false,
  "RD": true,
  "RA": true,
  "AD": false,
  "CD": false,
  "Question": [
    {
      "name": "weltraumschaf.de.",
      "type": 1
    }
  ],
  "Answer": [
    {
      "name": "weltraumschaf.de.",
      "type": 1,
      "TTL": 592,
      "data": "46.4.82.203"
    }
  ]
}
```

That's no big deal, eh? Yes it is!

Maybe you are not so familiar with DNS, but the standard provides a so called [TXT Resource Record][wiki-dns] in which you can store arbitrary text. Bingo! The solution is [Base64][wiki-base64] encode your payload and store it into a TXT record:

```text
@   IN    TXT   VGhpcyBpcyBzZWNyZXQgc2F1Y2UhCg==
```

I'm not sure how much data you can store in a _TXT Resource Record_. In the mentioned blog post they described that they only stored some IP addresses. But with [Base64][wiki-base64] encoding you can store anything in it.

The big advantage is that Google provides the API via HTTPS so inspection is not so easy. So you can use your own random hostname. Without TLS-breaking [DPI][wiki-dpi] this is not visible to potential victims.

Here's an example I deployed to my DNS:

```text
curl -sS 'https://dns.google.com/resolve?name=weltraumschaf.de&type=txt' | \
  jq .Answer[1].data | \
  tr -d '\\"' | \
  base64 -D -
```

Which decodes to:

```text
This is secret sauce!
```

[hiding-1]:     https://blog.huntresslabs.com/hiding-in-plain-sight-556469e0a4e
[hiding-2]:     https://blog.huntresslabs.com/hiding-in-plain-sight-part-2-dfec817c036f
[google-dns]:   https://dns.google.com/
[wiki-dns]:     https://de.wikipedia.org/wiki/Resource_Record
[wiki-base64]:  https://en.wikipedia.org/wiki/Base64
[wiki-dpi]:     https://en.wikipedia.org/wiki/Deep_packet_inspection