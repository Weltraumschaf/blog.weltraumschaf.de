#!/usr/bin/env bash

set -eu

#
# Helper script to create a new blog post file with capitalisted title.
#

if [ $# = 0 ]; then
  >&2 echo "USAGE: $(basename "${0}") give some words for the title"
  exit 1
fi

# https://github.com/nickjj/title-case-converter
title="${*}"
filename="${title// /-}.md"

echo "Title:    ${title}"
echo "Filename: ${filename}"

hugo new "blog/${filename}"
