#!/usr/bin/env bash

if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi

socat TCP-LISTEN:80,fork EXEC:./serverimpl.sh

