#!/usr/bin/env bash

VERSION=$1

echo "Creating version ${VERSION}"

./buildBase.sh && ./buildTest.sh && ./buildChrome.sh && ./buildTestWithPdf.sh && ./buildChromeWithPdf.sh && ./combineReports.sh && ./tagAndPush.sh ${VERSION}
