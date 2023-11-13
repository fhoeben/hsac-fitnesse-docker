ARG  BASE_IMAGE=hsac/fitnesse-fixtures-test-jre11:base-latest
ARG  GRAALVM_IMAGE=ghcr.io/graalvm/native-image:latest
ARG  BUSYBOX_IMAGE=busybox:latest

FROM ${BASE_IMAGE} as base

FROM ${GRAALVM_IMAGE} as graal

FROM graal as graal-fitnesse
RUN mkdir -p /fitnesse/target

WORKDIR /fitnesse

COPY --from=base /usr/src/combine/target/hsac-html-report-generator.jar target/
ENV JAVA_TOOL_OPTIONS="-Djdk.lang.Process.launchMechanism=vfork"
RUN native-image -jar target/hsac-html-report-generator.jar --static

FROM ${BUSYBOX_IMAGE} as busybox

FROM busybox
WORKDIR /fitnesse
VOLUME /fitnesse/target

ENTRYPOINT ["/fitnesse/hsac-html-report-generator"]
CMD []

COPY --from=graal-fitnesse /fitnesse/hsac-html-report-generator .
