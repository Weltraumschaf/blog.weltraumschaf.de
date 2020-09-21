---
title: "Improve Your Documentation With Russian Roulette"
date: 2020-09-21T11:33:41+02:00
lastmod: 2020-09-21T11:33:41+02:00
tags:
  - documentation
  - review
categories:
  - miscellaneous
imgs: []
cover: ""  # image show on top
toc: true
comments: false
justify: false  # text-align: justify;
single: false  # display as a single page, hide navigation on bottom, like as about page.
license: 'Published under the <a href="https://www.weltraumschaf.de/the-beer-ware-license.txt">THE BEER-WARE LICENSE</a>.'
authors: Sven Strittmatter
---

As software dudes we write documentation. Of course we do. Most of the time we write some API docs (JavaDoc or such) in the source code. This is not a big deal in my opinion. You do this as well as writing code and tests. Also you review this regularly within the normal code reviews. Yeah, code reviews are something normal in my world! But some times we're urged to write some documentation outside of the source code. Like system documentation or how-tos. Rather large documents. If you only change smaller parts which will be reviewed you'll end in a slightly outdated and inconsistent documentation.

At my work we encountered exactly this problem in one of my teams: We have a really good documentation about the maintained system: It's [AsciiDoc][asciidoc] based with [PlantUML][plantuml] images and contains only the necessary stuff. We thought. Until one of us needed some guidance and found out that the whole document was quite an outdated mess. Despite we did reviews on each commit!

## The Problem

Such documentation needs to be read as whole document from time to time to encounter inconsistencies. If you only review a small part with updated information you will not recognize that this update may outdate other chapters or make them inconsistent. Usually documents are build by chapters which depend on each other. So the first chapter is the foundation for the second one and so on. Sometimes chapters refer back to previous ones or you go even nuts and have random cross references. These are usually not so obvious like code dependencies because they lie in the semantic of the text. So you should read the whole document to verify that everything fits together in whole text. But this is not feasible. Nobody wants to read ten or twenty pages or more of documentation on each review. This would delay every review tremendously. And frankly kills all joy on doing documentation stuff. Which is already not that delightful for the most of us, sadly.

## The Solution

We came up with a very simple solution: One should review and read the whole documentation once a month and fix the inconsistencies and outdated information. This happens independent from regularly reviews and as dedicated task. So we implemented a simple shell script which fires an email to one random team member with the message:

> Heyho Sven,
>
> You have the honor to review our documentation: https://...
>
> TIA
> --Russian Roulette

To make it a fair job we remember the last "victim" of the script in a file and do a random shot again until it would hit someone else.

## Russian Roulette

The script is very simple and is based in our case on [msmtp][msmtp] which is a tool to send emails and [jq][jq] which is a CLI tool to process JSON. Here is a slightly modified version of our script. We use some [Ansible][ansible] templating stuff to customize and deploy it. This is left here for simplicity.

```bash
#!/usr/bin/env bash

set -ue

# This is the binary to send mails.
SEND_MAIL_BIN='/usr/bin/msmtp'
# This is the complete team as JSON string.
TEAM_JSON='[{"name": "John", "email": "john.doe@foobar.com"}, {"name": "Jane", "email": "jane.doe@foobar.com"}, ...]'
# This is URL to the doc to review.
RUSSIAN_ROULETTE_DOCU_URL='https://...'
# This is the mailer binary.
SEND_MAIL_FROM='team@foobar.com'

# We track the last victim to prevent that someone got hit twice in sequence.
LAST_VICTIM_FILE="${HOME}/.russian-roulette"
LAST_VICTIM_EMAIL=""

if [ -f "${LAST_VICTIM_FILE}" ]; then
    LAST_VICTIM_EMAIL=$(cat "${LAST_VICTIM_FILE}")
fi

# Picks a random victim from the team JSON.
random_victim() {
    count=$(jq '. | length' <<< "${TEAM_JSON}")
    index=$(( RANDOM % count ))
    victim=$(jq ".[$index]" <<< "${TEAM_JSON}")
    echo "${victim}"
    return 0
}

# Picks a random victim as long as it is not then same as the last one.
find_victim() {
    while true; do
        hit=$(random_victim)
        email=$(jq '.email' <<< "${hit}" | tr -d '"')

        if [ "${email}" != "${LAST_VICTIM_EMAIL}" ]; then
            echo "${hit}"
            return 0
        fi
    done
}

echo "Last victim was: ${LAST_VICTIM_EMAIL}"
VICTIM=$(find_victim)
VICTIM_EMAIL=$(jq '.email' <<< "${VICTIM}" | tr -d '"') # Remove enclosing quotes.
VICTIM_NAME=$(jq '.name' <<< "${VICTIM}" | tr -d '"') # Remove enclosing quotes.

# Send the mail by writing to STDIN of mailer.
${SEND_MAIL_BIN} "${VICTIM_EMAIL}" << EOF
Subject: You got hit!
To: ${VICTIM_EMAIL}
From: ${SEND_MAIL_FROM}

Heyho ${VICTIM_NAME},

You have the honor to review our documentation: ${RUSSIAN_ROULETTE_DOCU_URL}

TIA
--Russian Roulette

EOF

echo "Hit mail sent to ${VICTIM_EMAIL}."
echo -n "${VICTIM_EMAIL}" > "${LAST_VICTIM_FILE}"
```

The dependencies you need are:

- [msmtp][msmtp]
- [jq][jq]

Do I really need these tools? No, you don't! If you have another tool for sending mails already installed and configured you should change the script and use that one. Also you need not configure the list of "victims" with JSON! In our case it was the simplest approach to get this list from an [Ansible][[ansible](https://www.ansible.com/)] YAML into our script. Feel free to change this as well.

[msmtp]:    https://marlam.de/msmtp/
[jq]:       https://stedolan.github.io/jq/
[ansible]:  https://www.ansible.com/