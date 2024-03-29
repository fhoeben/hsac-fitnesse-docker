#!/usr/bin/env bash

VERSION_SUFFIX=$1
SELENIUM_VERSION=${2:-4.1.2}${VERSION_SUFFIX}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8-chrome:latest${VERSION_SUFFIX}

docker pull selenium/standalone-chrome:${SELENIUM_VERSION}

docker build  --platform linux/amd64 --build-arg SELENIUM_VERSION=${SELENIUM_VERSION} -t ${IMAGE} chrome

retVal=$?
if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    docker run --platform linux/amd64 --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/chrome${VERSION_SUFFIX}:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/chrome-rerun${VERSION_SUFFIX}:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/target/selenium-log${VERSION_SUFFIX}:/fitnesse/target/selenium-log \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.BrowserTest
    retVal=$?
fi
exit ${retVal}
