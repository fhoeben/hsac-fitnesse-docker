ARG TEST_VERSION=latest
ARG TEST_CHROME_VERSION=latest

FROM hsac/fitnesse-fixtures-test-jre8-with-pdf:${TEST_VERSION} as test

FROM hsac/fitnesse-fixtures-test-jre8-chrome:${TEST_CHROME_VERSION}
COPY --from=test /fitnesse/wiki/fixtures /fitnesse/wiki/fixtures
