#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-test-jre8:latest

docker run --rm -it --entrypoint /fitnesse/htmlReportIndexGenerator.sh \
    -v ${BASEDIR}/target/fitnesse-results/:/fitnesse/target/fitnesse-results \
     ${IMAGE}
