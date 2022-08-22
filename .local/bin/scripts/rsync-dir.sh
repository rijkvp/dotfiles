#!/bin/sh
dir=$1
remote_name=$2
cmd="rsync -ahP --stats --exclude \".*\" --delete-after"
local="$HOME/$dir/"
remote="$remote_name:~/$dir/"
if [ "$3" = "rev" ]
then
    echo "[REVERSE MODE]"
    src=$remote
    dst=$local
else
    src=$local
    dst=$remote
fi
echo "Source: $src Destination: $dst"
echo "Proceed with operation? [enter YES]"
read confirm
if [ "$confirm" = "YES" ]
then
    echo "Starting rsync operation.."
    $cmd $src $dst
else
    echo "Operation cancelled."
fi
