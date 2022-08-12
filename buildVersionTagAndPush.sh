#!/usr/bin/env bash

VERSION=$1
PLATFORM=${2:-arm64}

echo "Creating version ${VERSION}"

rm -rf target

export TEST_IMAGES=true

./buildBase.sh ${VERSION} \
    && ./buildTest.sh ${VERSION} \
    && ./buildTestWithPdf.sh ${VERSION} \
    && ./buildChrome.sh ${VERSION} \
    && ./buildChromeWithPdf.sh ${VERSION} \
    && ./buildCombine.sh ${VERSION} \
    && ./combineReports.sh ${VERSION} \
    && ./tagAndPush.sh ${VERSION} ${PLATFORM}
