#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..
VERSION=${1:-latest}

rm -rf ${BASEDIR}/target
docker-compose down

export VERSION

docker-compose up

docker run --rm \
    -v ${BASEDIR}/target/fitnesse-results:/fitnesse/target/fitnesse-results \
    hsac/fitnesse-fixtures-combine:${VERSION}

docker-compose down
