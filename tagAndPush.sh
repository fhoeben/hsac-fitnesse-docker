#!/usr/bin/env bash

VERSION=$1
PLATFORM=$2

if [[ "$PLATFORM" != "" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8:base-${VERSION} hsac/fitnesse-fixtures-test-jre8:base-${VERSION}-${PLATFORM}
  docker tag hsac/fitnesse-fixtures-combine:${VERSION} hsac/fitnesse-fixtures-combine:${VERSION}-${PLATFORM}
  docker tag hsac/fitnesse-fixtures-test-jre8:${VERSION} hsac/fitnesse-fixtures-test-jre8:${VERSION}-${PLATFORM}
  docker tag hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION} hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION}-${PLATFORM}
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION} hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}-${PLATFORM}
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION} hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}-${PLATFORM}
fi

echo "Pushing base-${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-test-jre8:base-${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8:base-${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-test-jre8:base-latest-${PLATFORM}
  echo "Pushing base-latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-test-jre8:base-latest-${PLATFORM}
fi

echo "Pushing combine:${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-combine:${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-combine:${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-combine:latest-${PLATFORM}
  echo "Pushing combine:latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-combine:latest-${PLATFORM}
fi

echo "Pushing test:${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-test-jre8:${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8:${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-test-jre8:latest-${PLATFORM}
  echo "Pushing test:latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-test-jre8:latest-${PLATFORM}
fi

echo "Pushing test-with-pdf:${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-with-pdf:${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-test-jre8-with-pdf:latest-${PLATFORM}
  echo "Pushing with-pdf:latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-test-jre8-with-pdf:latest-${PLATFORM}
fi

echo "Pushing chrome:${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome:${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-test-jre8-chrome:latest-${PLATFORM}
  echo "Pushing chrome:latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome:latest-${PLATFORM}
fi

echo "Pushing chrome-with-pdf:${VERSION}-${PLATFORM}"
docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}-${PLATFORM}

if [[ "$VERSION" != "latest" ]]; then
  docker tag hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:${VERSION}-${PLATFORM} hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest-${PLATFORM}
  echo "Pushing chrome-with-pdf:latest-${PLATFORM}"
  docker push hsac/fitnesse-fixtures-test-jre8-chrome-with-pdf:latest-${PLATFORM}
fi
