#!/usr/bin/env bash

VERSION=$1
VERSION_SUFFIX=$2

echo "Creating version ${VERSION} and ${VERSION}${VERSION_SUFFIX}"

./buildBase.sh \
    && ./buildTest.sh \
    && ./buildTestWithPdf.sh \
    && ./buildChrome.sh ${VERSION_SUFFIX} \
    && ./buildChromeWithPdf.sh ${VERSION_SUFFIX} \
    && ./buildChrome.sh \
    && ./buildChromeWithPdf.sh \
    && ./combineReports.sh \
    && ./tagAndPush.sh ${VERSION} ${VERSION_SUFFIX}
