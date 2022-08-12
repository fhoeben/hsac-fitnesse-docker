#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=${1:-latest}
IMAGE=hsac/fitnesse-fixtures-test-jre8:${VERSION}

docker run --rm --entrypoint /fitnesse/htmlReportIndexGenerator.sh \
    -v ${BASEDIR}/target/fitnesse-results/:/fitnesse/target/fitnesse-results \
     ${IMAGE}

echo "Generated overview is saved as: ${BASEDIR}/target/fitnesse-results/index.html"
