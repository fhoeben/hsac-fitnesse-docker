ARG  TEST_VERSION=latest
ARG  SELENIUM_VERSION=3.11.0
FROM hsac/fitnesse-fixtures-test-jre8:${TEST_VERSION} as hsac-fixtures

FROM selenium/standalone-chrome:${SELENIUM_VERSION}
COPY --from=hsac-fixtures --chown=seluser:seluser /fitnesse /fitnesse

WORKDIR /fitnesse

RUN mkdir -p /fitnesse/target/selenium-log
COPY --chown=seluser:seluser startGridAndRunTests.sh .

VOLUME /fitnesse/target
VOLUME /fitnesse/wiki/FitNesseRoot

ENV FITNESSE_OPTS -DseleniumBrowser=chrome -DseleniumGridUrl=http://localhost:4444/wd/hub

ENTRYPOINT ["/fitnesse/startGridAndRunTests.sh"]
CMD []