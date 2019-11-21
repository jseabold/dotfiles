#! /bin/sh

DEVICE=/sys/class/backlight/intel_backlight/brightness
BRIGHTNESS=$(cat $DEVICE)

if test $BRIGHTNESS -lt 4882; then
    echo $((BRIGHTNESS + 244)) | sudo tee $DEVICE
fi
