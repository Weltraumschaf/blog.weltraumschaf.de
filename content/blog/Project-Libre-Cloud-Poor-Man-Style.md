---
title: "Project Libre Cloud Poor Man Style"
date: 2022-03-23T15:22:23+01:00
lastmod: 2022-03-23T15:22:23+01:00
tags: 
    - project management
    - bash
    - macos
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
draft: true
---

Disclaimer: The solution presented here is macOS only!

Some days ago we encountered the need for some project management tool for my team at my employer. We're a central security team providing services to our project teams and customers. The last months we saw more andmore demand for our services and we're faced a quite complex situation. We need to allocate the tema members to some small projects (like threat modellings or a security training) or larger projects (like implementing secureCodeBox in a project or consulting a customer to build their own security comunity). First attempt was to do it with Excel, of course :-) But Excel lacks one major feature: You can't realy model somethin in three dimensions. Of course, it's made for tables. But a typicall project team allocation problem spans overthree dimensions:

1. The projects to be done,
2. the team members, 
3. and finaly time.

Here typical project management tolls (such as MS PRoject or Project Libre) come into play. They don't really show you something in 3D, but they try more or less good to modell these three dimensions. (There are resource plans, Gnatt charts and cummulative resource diagrams and such.) You se, I'm not a project management geek ;-)

We decided to give PRoject Libre a try and find out ifit helps us with our problem. But there is one major use case Project Libre does not address: Concurrent modification of the data. Since we do not have one sinlge project manager, but a self-organized agile team, it is necessary that more than one person edits the file. We decided to give our busines cloud storage a try. Problem: Project Libre does not create a lock if it opens a file. So, it is possible to run into a lost update problem, if two or more persons edit thefileconcurrently.

Project Libre Enterprise for the rescue, I thouhght. But it is closed beta. Not much information and loocking into the few screenshot it seem to be a complete different UI.

My colleage came up with the idea of a wrapper script which checks and creates for a lock file. I say "hold my beer":

```shell
#!/usr/bin/env bash

set -euo pipefail

#
# Make Project Libre "Cloud Ready"
#
# This is macOS only!
#
# This is a wrapper script for ProjectLibre.app (brew install projectlibre) that creates a lock file
# a along side with the opend file to prevent opening it twice. This is done because we wnat to share the
# project in our cloud storage.
#
# This is not 100 % safe. There may be soem seconds this implementation is vulnarable on concurrent file
# access. But itis better than nothing to prevent lost updates.
#

USAGE="Usage: $(basename "$0") <path/to/file.pod>"

echo_err() {
    >&2 echo "${1}"
}

acquire_lock() {
    local pod_file_lock
    pod_file_lock="${1}"

    echo "Try to get lock..."

    if [[ -e "${pod_file_lock}" ]]; then
        echo_err "Error: Can't acquire lock! Lock file '${pod_file_lock}' already exists."
        exit 1
    fi

    touch "${pod_file_lock}"
    echo "$USER:$(date)" > "${pod_file_lock}"
    echo "Lock file written: ${pod_file_lock}"
}

release_lock() {
    local pod_file_lock
    pod_file_lock="${1}"

    if [[ -e "${pod_file_lock}" ]]; then
        rm -rf "${pod_file_lock}"
        echo "Lock released."
    else
        echo_err "Warning: Can't release lock! Lock file '${pod_file_lock}' does not exist exists."
    fi
}

open_project_libre() {
    local pod_file
    pod_file="${1}"

    open --wait-apps -a ProjectLibre "${pod_file}"
}

main() {
    if [[ "$#" != "1" ]]; then
        echo_err "Error: Wrong number of arguments! Only one path to .pod file allowed as argument."
        echo_err "$USAGE"
        exit 1
    fi

    local pod_file pod_file_lock
    pod_file="${1}"
    pod_file_lock="${pod_file}.locked"

    acquire_lock "${pod_file_lock}"
    open_project_libre "${pod_file}"
    release_lock "${pod_file_lock}"
}

main "$@"
```

Then instead of directly open Project Libre via `open -a ProjectLibre file.pod` or double clicking you call the above script `disco file.pod`. (I named it "disco" for reasons™.)

You can install Project Libre via brew: `brew instal projectlibre`

The locking works quite simple: On opening the file there is a prior check if there is a file named same as the file to open with extension `.locked`. If it exists the script aborts with an error message. If it is absent it creates the lock file and opens it. In the lock file the `$USER` and current date is printed. This is helpfull to identify the last person who locked the file.

Of course, this is not a perfet solution. There may be a small time gap for race conditions: It takes some time to sync my local lock file via cloud storage to all my team mates. But, I think this solution