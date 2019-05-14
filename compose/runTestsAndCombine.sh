#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..
VERSION=${1:-latest}

rm -rf ${BASEDIR}/target
docker-compose down

export VERSION

docker-compose up

${BASEDIR}/combineReports.sh

docker-compose down
