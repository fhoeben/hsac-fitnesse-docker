#!/usr/bin/env bash

SELENIUM_VERSION=${1:-3.12}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8-chrome:latest

docker build --squash --build-arg SELENIUM_VERSION=${SELENIUM_VERSION} -t ${IMAGE} chrome \
    && docker run --rm \
        -v ${BASEDIR}/target/failsafe-reports:/fitnesse/target/failsafe-reports \
        -v ${BASEDIR}/target/fitnesse-results/chrome:/fitnesse/target/fitnesse-results \
        -v ${BASEDIR}/target/selenium-log:/fitnesse/target/selenium-log \
        -v ${BASEDIR}/src/main/wiki:/fitnesse/wiki/FitNesseRoot \
        ${IMAGE} \
        -DfitnesseSuiteToRun=SampleTests.SlimTests.BrowserTest
