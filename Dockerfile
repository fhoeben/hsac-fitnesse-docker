FROM openjdk:8-jre-alpine

RUN mkdir -p /fitnesse/wiki/fixtures/nl/hsac/fitnesse

WORKDIR /fitnesse

RUN mkdir target
VOLUME /fitnesse/target

RUN mkdir wiki/FitNesseRoot
VOLUME /fitnesse/wiki/FitNesseRoot

COPY wiki/ wiki/
COPY runTests.sh .
COPY htmlReportIndexGenerator.sh .

ENTRYPOINT ["/fitnesse/runTests.sh"]
CMD []