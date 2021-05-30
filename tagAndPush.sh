#!/usr/bin/env bash

VERSION=$1
VERSION_SUFFIX=$2

echo "Pushing base-latest"
docker push hsac/fitnesse-fixtures-test-jre8:base-latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8:base-latest hsac/fitnesse-fixtures-test-jre8:base-${VERSION}
  echo "Pushing base-${VERSION}"
  docker push hsac/fitnesse-fixtures-test-jre8:base-${VERSION}
fi

echo "Pushing combine latest"
docker push hsac/fitnesse-fixtures-combine:latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-combine:latest hsac/fitnesse-fixtures-combine:${VERSION}
  echo "Pushing combine ${VERSION}"
  docker push hsac/fitnesse-fixtures-combine:${VERSION}
fi

echo "Pushing latest"
docker push hsac/fitnesse-fixtures-test-jre8:latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8:latest hsac/fitnesse-fixtures-test-jre8:${VERSION}
  echo "Pushing ${VERSION}"
  docker push hsac/fitnesse-fixtures-test-jre8:${VERSION}
fi

echo "Pushing with-pdf:latest"
docker push hsac/fitnesse-fixtures-test-jre8-with-pdf:latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-with-pdf:latest hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION}
  echo "Pushing with-pdf:${VERSION}"
  docker push hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION}
fi

echo "Pushing chrome:latest"
docker push hsac/fitnesse-fixtures-test-jre8-chrome:latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome:latest hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}
  echo "Pushing chrome:${VERSION}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}
fi

echo "Pushing chrome-with-pdf:latest"
docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}
  echo "Pushing chrome-with-pdf:${VERSION}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}
fi

echo "Pushing chrome:latest${VERSION_SUFFIX}"
docker push hsac/fitnesse-fixtures-test-jre8-chrome:latest${VERSION_SUFFIX}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome:latest${VERSION_SUFFIX} hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}${VERSION_SUFFIX}
  echo "Pushing chrome:${VERSION}${VERSION_SUFFIX}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}${VERSION_SUFFIX}
fi

echo "Pushing chrome-with-pdf:latest${VERSION_SUFFIX}"
docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest${VERSION_SUFFIX}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest${VERSION_SUFFIX} hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}${VERSION_SUFFIX}
  echo "Pushing chrome-with-pdf:${VERSION}${VERSION_SUFFIX}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}${VERSION_SUFFIX}
fi
