#!/bin/sh

if [ -x "/usr/bin/fish" ]; then
    fish -c "set -U fish_greeting"
fi
