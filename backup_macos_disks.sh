#!/bin/bash

#  Program: photobackup 0.2.1 by peter@forret.com
#  Updated: Oct 26 11:30:31 2025
#  Description: Backup photos to NAS
#  Usage: photobackup [-h] [-q] [-v] [-f] [-l <log_dir>] [-t <tmp_dir>] [-s <source>] [-d <destin>] <action>
#  Flags, options and parameters:
#  -h|--help        : [flag] show usage [default: off]
#  -q|--quiet       : [flag] no output [default: off]
#  -v|--verbose     : [flag] output more [default: off]
#  -f|--force       : [flag] do not ask for confirmation (always yes) [default: off]
#  -l|--log_dir <?> : [option] folder for log files   [default: /Users/pforret/log/photobackup]
#  -t|--tmp_dir <?> : [option] folder for temp files  [default: /tmp/photobackup]
#  -s|--source <?>  : [option] source folder
#      -d|--destin <?>  : [option] destination folder
#  <action>         : [parameter] action to perform: backup/check

DESTINATION="/Volumes/photo"
[[ ! -d "$DESTINATION" ]] && echo "Error: Destination $DESTINATION not found" && exit 1

# Get the directory where this script is located
PHOTOBACKUP="$(which photobackup)"

# Check if photobackup script exists
if [[ ! -f "$PHOTOBACKUP" ]]; then
    echo "Error: photobackup.sh not found at $PHOTOBACKUP"
    exit 1
fi

# List all mounted volumes and check for Originals folder
while IFS= read -r mount_point; do
    # Skip empty lines
    [[ -z "$mount_point" ]] && continue
    [[ ! -d "$mount_point/Originals" ]] && continue
    echo "Found Originals in: $mount_point"
    echo "Running: $PHOTOBACKUP -s \"$mount_point/Originals\" -d \"$DESTINATION/Originals\" backup"
    "$PHOTOBACKUP" -s "$mount_point/Originals" -d "$DESTINATION/Originals" backup
done < <(mount | grep -E '^/dev/' | awk '{print $3}')
