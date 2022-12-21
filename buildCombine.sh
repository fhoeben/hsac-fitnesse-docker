#!/usr/bin/env bash

VERSION=${1:-latest}
GRAALVM_VERSION=${2:-latest}
BUSYBOX_VERSION=latest

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BASE_IMAGE=hsac/fitnesse-fixtures-test-jre11:base-${VERSION}
export GRAALVM_IMAGE=ghcr.io/graalvm/native-image:${GRAALVM_VERSION}
export BUSYBOX_IMAGE=busybox:${BUSYBOX_VERSION}
IMAGE=hsac/fitnesse-fixtures-combine:${VERSION}

docker pull ${GRAALVM_IMAGE}
docker pull ${BUSYBOX_IMAGE}

docker build --squash --build-arg BASE_IMAGE --build-arg GRAALVM_IMAGE --build-arg BUSYBOX_IMAGE -t ${IMAGE} combine

retVal=$?
if [[ ${retVal} -eq 0 ]]; then
    docker run --rm \
        -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
        ${IMAGE}
    retVal=$?
fi
exit ${retVal}
