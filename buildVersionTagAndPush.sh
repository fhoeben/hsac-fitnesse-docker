#!/usr/bin/env bash

VERSION=$1

echo "Creating version ${VERSION}"

./buildBase.sh && ./buildTest.sh && ./buildChrome.sh && ./combineReports.sh && ./tagAndPush.sh ${VERSION}
