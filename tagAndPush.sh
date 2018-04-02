#!/usr/bin/env bash

VERSION=$1

echo "Pushing base-latest"
docker push hsac/fitnesse-fixtures-test-jre8:base-latest

docker tag hsac/fitnesse-fixtures-test-jre8:base-latest hsac/fitnesse-fixtures-test-jre8:base-${VERSION}
echo "Pushing base-${VERSION}"
docker push hsac/fitnesse-fixtures-test-jre8:base-${VERSION}

echo "Pushing latest"
docker push hsac/fitnesse-fixtures-test-jre8:latest

docker tag hsac/fitnesse-fixtures-test-jre8:latest hsac/fitnesse-fixtures-test-jre8:${VERSION}
echo "Pushing ${VERSION}"
docker push hsac/fitnesse-fixtures-test-jre8:${VERSION}

echo "Pushing latest"
docker push hsac/fitnesse-fixtures-test-jre8-chrome:latest

docker tag hsac/fitnesse-fixtures-test-jre8-chrome:latest hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}
echo "Pushing ${VERSION}"
docker push hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}

