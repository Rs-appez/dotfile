#!/bin/bash

# Source: https://gist.github.com/tsjnachos117/8231f9f8ed08968cc5f1a7f4d3e06b0e

# Set your device ID here
DEVICE_ID="2714d67242e340d1b1ceb1f308258b0a"

# Query battery percentage via dbus-send
PERCENT=$(dbus-send --print-reply --dest=org.kde.kdeconnect \
  /modules/kdeconnect/devices/$DEVICE_ID/battery \
  org.freedesktop.DBus.Properties.Get \
  string:org.kde.kdeconnect.device.battery string:charge | \
  awk '/variant/ {print $3}' | tr -d '"')

echo "{\"text\": \"${PERCENT}%\"}"


