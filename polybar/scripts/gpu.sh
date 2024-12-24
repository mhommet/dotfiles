#!/bin/sh

if hash nvidia-smi 2>/dev/null; then
    # nvidia-smi is installed, so run the command
    nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print "",""$1"","%"}'
else
    # nvidia-smi is not installed, so do nothing
    :
fi
