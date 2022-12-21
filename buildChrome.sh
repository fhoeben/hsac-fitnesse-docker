#!/usr/bin/env bash

VERSION=${1:-latest}
SELENIUM_VERSION=${2:-latest}
export SELENIUM_IMAGE=seleniarm/standalone-chromium:${SELENIUM_VERSION}
export TEST_IMAGE=hsac/fitnesse-fixtures-test-jre11:${VERSION}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre11-chrome:${VERSION}

docker pull ${SELENIUM_IMAGE}

docker build --build-arg SELENIUM_IMAGE --build-arg TEST_IMAGE -t ${IMAGE} chrome

retVal=$?
if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    docker run --rm \
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
