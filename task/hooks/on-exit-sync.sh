#!/usr/bin/env bash

count=0
while read -r; do
    count=$((count + 1))
done

if ((count > 0)); then
    exec task sync | tee ~/.task/sync_hook.log
else
    echo "No changes to sync"
fi
