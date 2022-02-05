#!/usr/bin/env bash

GRAALVM_VERSION=${1:-latest}
BUSYBOX_VERSION=latest

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-combine:latest

docker pull ghcr.io/graalvm/graalvm-ce:${GRAALVM_VERSION}
docker pull busybox:${BUSYBOX_VERSION}

docker build --platform linux/amd64 --squash -t ${IMAGE} combine

retVal=$?
if [[ ${retVal} -eq 0 ]]; then
    docker run --rm \
        -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
        ${IMAGE}
    retVal=$?
fi
exit ${retVal}
