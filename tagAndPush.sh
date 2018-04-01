#!/usr/bin/env bash

VERSION=$1

docker push hsac/fitnesse-fixtures-test-jre8:latest

docker tag hsac/fitnesse-fixtures-test-jre8:latest hsac/fitnesse-fixtures-test-jre8:${VERSION}
docker push hsac/fitnesse-fixtures-test-jre8:${VERSION}

docker push hsac/fitnesse-fixtures-test-jre8-chrome:latest

docker tag hsac/fitnesse-fixtures-test-jre8-chrome:latest hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}
docker push hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}

