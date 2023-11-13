ARG TEST_PDF_IMAGE=hsac/fitnesse-fixtures-test-jre11-with-pdf:latest
ARG TEST_CHROME_IMAGE=hsac/fitnesse-fixtures-test-jre11-chrome:latest

FROM ${TEST_PDF_IMAGE} as test-with-pdf

FROM ${TEST_CHROME_IMAGE} as hsac-chrome

FROM hsac-chrome
COPY --from=test-with-pdf /fitnesse/wiki/fixtures /fitnesse/wiki/fixtures
