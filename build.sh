#!/bin/sh

sudo systemctl stop caddy
sleep 0.05
rm /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public/* -r
sleep 0.05
cd /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/magenta-blog
sleep 0.05
hugo
sleep 0.05
cp Caddyfile /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public
sleep 0.05
#caddy start --config /mnt/ddf46e84-10c6-40fb-85b2-99f14e503946/selfhost/Magenta-blog-Public/Caddyfile
sudo systemctl start caddy
