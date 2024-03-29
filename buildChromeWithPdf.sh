#!/usr/bin/env bash

VERSION_SUFFIX=$1

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest${VERSION_SUFFIX}
TEST_CHROME_IMAGE=hsac/fitnesse-fixtures-test-jre8-chrome:latest${VERSION_SUFFIX}

docker build --platform linux/amd64 --build-arg TEST_CHROME_IMAGE=${TEST_CHROME_IMAGE} -t ${IMAGE} chrome-with-pdf

retVal=$?
if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    docker run --platform linux/amd64 --rm \
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
