#!/bin/sh

cd /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/magenta-blog

echo "Enter post name (.md is added automatically)"

read postname

hugo new posts/$postname.md

xed content/posts/$postname.md
