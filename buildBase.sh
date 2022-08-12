#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=${1:-latest}
IMAGE=hsac/fitnesse-fixtures-test-jre8:base-${VERSION}

docker build --pull -t ${IMAGE} .
