#!/usr/bin/env sh

set -e

# ensure user of container is owner of all mounted volumes
sudo chown -R 1200:1201 /fitnesse/

/opt/bin/entry_point.sh &
while [ ! -e /tmp/.X11-unix/X99 ]; do sleep 0.1; done

./runTests.sh "$@"
