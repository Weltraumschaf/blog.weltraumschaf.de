#!/usr/bin/env bash

set -eu

#
# Helper script to create a new blog post file with capitalisted title.
#

if [ $# = 0 ]; then
  echo "USAGE: $(basename "${0}") givesome words for the title"
  exit 1
fi

# https://github.com/nickjj/title-case-converter
title=$(tcc "${*}")
filename="${title// /-}.md"

echo "Title:    ${title}"
echo "Filename: ${filename}"

hugo new "blog/${filename}"
