#!/bin/bash

if [ "$1" == "connect" ]; then
    sudo wg-quick up Wireguard
elif [ "$1" == "disconnect" ]; then
    sudo wg-quick down Wireguard
else
    echo "Usage: $0 {connect|disconnect}"
fi
