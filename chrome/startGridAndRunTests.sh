#!/usr/bin/env sh

/opt/bin/entry_point.sh > target/selenium-log/selenium.log &

set -e

while ! curl -sSL "http://localhost:4444/wd/hub/status" 2>&1 \
        | jq -r '.value.ready' 2>&1 | grep "true" >/dev/null; do
    echo 'Waiting for the Grid'
    sleep 1
done

>&2 echo "Selenium Grid is up - executing tests"

./runTests.sh $@
