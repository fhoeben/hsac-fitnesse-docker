#!/usr/bin/env bash

TEST_IMAGES=true
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=${1:-5.3.1}
TAG=${2:-latest}

VERSION=${VERSION} TAG=${TAG} docker buildx bake --load

retVal=$?

if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    IMAGE=hsac/fitnesse-fixtures-test-jre11:${TAG}
    docker run --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/test:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/test-rerun:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.UtilityFixtures
    retVal=$?
fi

if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
    IMAGE=hsac/fitnesse-fixtures-test-jre11-chrome:${TAG}
    docker run --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/chrome:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/chrome-rerun:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/target/selenium-log:/fitnesse/target/selenium-log \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.BrowserTest
    retVal=$?
fi

if [[ ${retVal} -eq 0 ]]; then
    IMAGE=hsac/fitnesse-fixtures-combine:${TAG}
    docker run --rm \
        -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
        ${IMAGE}
    retVal=$?
fi
exit ${retVal}
