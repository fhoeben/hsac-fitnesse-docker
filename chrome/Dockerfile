FROM hsac/fitnesse-fixtures-test-jre8:latest as hsac-fixtures

FROM selenium/standalone-chrome:3.11.0
COPY --from=hsac-fixtures --chown=seluser:seluser /fitnesse /fitnesse

WORKDIR /fitnesse

RUN mkdir -p /fitnesse/target/selenium-log
COPY --chown=seluser:seluser startGridAndRunTests.sh .

VOLUME /fitnesse/target
VOLUME /fitnesse/wiki/FitNesseRoot

ENV FITNESSE_OPTS -DseleniumBrowser=chrome -DseleniumGridUrl=http://localhost:4444/wd/hub

ENTRYPOINT ["/fitnesse/startGridAndRunTests.sh"]
CMD []