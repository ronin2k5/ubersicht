#!/bin/zsh

/usr/local/bin/npm outdated | awk '{print $1;}'
