#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8-with-pdf:latest

docker build --squash -t ${IMAGE} test-with-pdf \
    && docker run --rm  \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/test-pdf:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/test-pdf-rerun:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.UtilityFixtures
