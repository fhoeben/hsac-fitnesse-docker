#!/usr/bin/env bash

JRE_VERSION=${1:-8-jre-alpine}

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-combine:latest

docker pull openjdk:${JRE_VERSION}

docker build --squash -t ${IMAGE} combine

retVal=$?
if [[ ${retVal} -eq 0 ]]; then
    docker run --rm \
        -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
        ${IMAGE}
    retVal=$?
fi
exit ${retVal}
