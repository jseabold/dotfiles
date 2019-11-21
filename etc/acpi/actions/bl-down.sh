#! /bin/sh

DEVICE=/sys/class/backlight/intel_backlight/brightness
BRIGHTNESS=$(cat $DEVICE)

if test $BRIGHTNESS -gt 2; then
    echo $((BRIGHTNESS - 244)) | sudo tee $DEVICE
fi
