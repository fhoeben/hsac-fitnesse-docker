#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=${1:-latest}
JRE_VERSION=${2:-11-jre}
JRE_IMAGE=eclipse-temurin:${JRE_VERSION}

export BASE_IMAGE=hsac/fitnesse-fixtures-test-jre11:base-${VERSION}
export IMAGE=hsac/fitnesse-fixtures-test-jre11:${VERSION}

docker pull ${JRE_IMAGE}

docker build --build-arg BASE_IMAGE --build-arg JRE_IMAGE -t ${IMAGE} test

retVal=$?
if [ ${retVal} -eq 0 -a "${TEST_IMAGES}" = "true" ]; then
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
exit ${retVal}
