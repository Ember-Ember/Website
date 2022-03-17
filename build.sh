#!/bin/sh

rm /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public/* -r
sleep 0.3
cd /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/magenta-blog
sleep 0.3
hugo
sleep 0.3
cp Caddyfile /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public
sleep 0.3
caddy run --config /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public/Caddyfile
