#!/usr/bin/env bash

GRAALVM_VERSION=${1:-latest}
BUSYBOX_VERSION=latest

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE=hsac/fitnesse-fixtures-combine:latest

docker pull ghcr.io/graalvm/native-image:${GRAALVM_VERSION}
docker pull busybox:${BUSYBOX_VERSION}

docker build --squash -f combine/Dockerfile-local -t ${IMAGE} combine

retVal=$?
if [[ ${retVal} -eq 0 ]]; then
    docker run --rm \
        -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
        ${IMAGE}
    retVal=$?
fi
exit ${retVal}
