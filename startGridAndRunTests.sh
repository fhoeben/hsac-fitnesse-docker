#!/usr/bin/env sh

/opt/bin/entry_point.sh > target/selenium-log/selenium.log &
./runTests.sh $@