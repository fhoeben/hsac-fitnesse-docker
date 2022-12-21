#!/usr/bin/env bash

VERSION=${1:-latest}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre11-chrome-with-pdf:${VERSION}
export TEST_CHROME_IMAGE=hsac/fitnesse-fixtures-test-jre11-chrome:${VERSION}
export TEST_PDF_IMAGE=hsac/fitnesse-fixtures-test-jre11-with-pdf:${VERSION}

docker build --build-arg TEST_CHROME_IMAGE --build-arg TEST_PDF_IMAGE -t ${IMAGE} chrome-with-pdf

retVal=$?
if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    docker run --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/chrome-pdf${VERSION_SUFFIX}:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/chrome-pdf-rerun${VERSION_SUFFIX}:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/target/selenium-log-pdf${VERSION_SUFFIX}:/fitnesse/target/selenium-log \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.BrowserTest
    retVal=$?
fi
exit ${retVal}
