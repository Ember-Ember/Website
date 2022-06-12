#!/bin/sh

cd /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/magenta-blog

echo "Enter post name and location relative to the content directory (posts/post-name for a regular post) (.md is added automatically)"

read postname

hugo new $postname.md

xed content/$postname.md
