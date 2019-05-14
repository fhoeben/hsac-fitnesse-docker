#!/usr/bin/env bash

JRE_VERSION=${1:-8-jre-alpine}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8:latest

docker pull openjdk:${JRE_VERSION}

docker build --squash -f test/Dockerfile-local -t ${IMAGE} test \
    && docker run --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/test:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/fitnesse-results/test-rerun:/fitnesse/target/fitnesse-rerun-results \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        -e RE_RUN_FAILED=true \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.UtilityFixtures
