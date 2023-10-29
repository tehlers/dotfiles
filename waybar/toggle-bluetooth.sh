#! /usr/bin/env bash

if bluetoothctl show | rg --quiet "Powered: no"; then
    bluetoothctl power on
else
    bluetoothctl power off
fi
