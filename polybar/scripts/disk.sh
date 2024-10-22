#!/usr/bin/env bash

# Get the remaining disk space for the home folder
df -h /home | awk 'NR==2 {print $4}'
