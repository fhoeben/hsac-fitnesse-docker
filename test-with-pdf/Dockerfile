ARG  BASE_VERSION=base-latest
ARG  TEST_VERSION=latest

FROM hsac/fitnesse-fixtures-test-jre8:${BASE_VERSION} as base
RUN mvn compile -P withPdf

FROM hsac/fitnesse-fixtures-test-jre8:${TEST_VERSION}
COPY --from=base /usr/src/test/wiki/fixtures wiki/fixtures
