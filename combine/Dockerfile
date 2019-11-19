ARG  BASE_VERSION=base-latest
ARG  GRAALVM_VERSION=latest
ARG  BUSYBOX_VERSION=latest

FROM hsac/fitnesse-fixtures-test-jre8:${BASE_VERSION} as base

FROM oracle/graalvm-ce:${GRAALVM_VERSION} as graal
RUN gu install native-image

WORKDIR /fitnesse

VOLUME /fitnesse/target

COPY --from=base /usr/src/combine/target/hsac-html-report-generator.jar target/

RUN native-image -jar target/hsac-html-report-generator.jar --static

FROM busybox:${BUSYBOX_VERSION}
WORKDIR /fitnesse
VOLUME /fitnesse/target

ENTRYPOINT ["/fitnesse/hsac-html-report-generator"]
CMD []

COPY --from=graal /fitnesse/hsac-html-report-generator .
