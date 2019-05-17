ARG  BASE_VERSION=base-latest
ARG  JRE_VERSION=8-jre-alpine

FROM hsac/fitnesse-fixtures-test-jre8:${BASE_VERSION} as base

FROM openjdk:${JRE_VERSION}
RUN mkdir -p /fitnesse/target

WORKDIR /fitnesse

VOLUME /fitnesse/target

ENTRYPOINT ["java", "-jar", "/fitnesse/target/hsac-html-report-generator.jar"]
CMD []

COPY --from=base /usr/src/combine/target/hsac-html-report-generator.jar target
