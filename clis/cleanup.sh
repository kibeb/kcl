#!/bin/bash
df -h .
apt autoremove --purge
apt clean
apt autoclean
journalctl --vacuum-time 2d
find /home -mindepth 2 -path */.cache/chromium/* -delete
find /home -mindepth 2 -path */.cache/mozilla/* -delete
echo '"du /":'
du / 2>/dev/null | sort -n | tail
echo '"swapon -v":'
swapon -v
echo '"df -h .":'
df -h .
