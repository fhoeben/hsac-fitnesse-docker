#!/usr/bin/env bash

VERSION=$1
VERSION_SUFFIX=$2
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Creating version ${VERSION} and ${VERSION}${VERSION_SUFFIX}"

export TEST_IMAGES=false

cd ..

./buildBase.sh \
    && ./buildCombine.sh \
    && ./buildTest.sh \
    && ./buildTestWithPdf.sh \
    && ./buildChrome.sh ${VERSION_SUFFIX} \
    && ./buildChromeWithPdf.sh ${VERSION_SUFFIX} \
    && ./buildChrome.sh \
    && ./buildChromeWithPdf.sh

retVal=$?
if [[ ${retVal} -eq 0 ]]; then
    cd ${BASEDIR}
    ./runTestsAndCombineCp.sh

    retVal=$?
    if [[ ${retVal} -eq 0 ]]; then
        cd ..
        ./tagAndPush.sh ${VERSION} ${VERSION_SUFFIX}
        retVal=$?
    fi
fi

cd ${BASEDIR}

exit ${retVal}
