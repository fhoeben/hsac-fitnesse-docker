ARG MAVEN_VERSION=3.8-amazoncorretto-11
ARG JRE_IMAGE=eclipse-temurin:11-jre
ARG SELENIUM_IMAGE=seleniarm/standalone-chromium:latest
ARG GRAALVM_IMAGE=ghcr.io/graalvm/native-image:latest
ARG BUSYBOX_IMAGE=busybox:latest
ARG VERSION=5.3.0

# ========== BASE ===========
FROM maven:${MAVEN_VERSION} as base
ARG VERSION

RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY pom.xml .

RUN mvn compile -Dhsac.fixtures.version=${VERSION}

COPY src/ ./src

RUN mvn package -Dhsac.fixtures.version=${VERSION}


# ========== TEST ===========
FROM ${JRE_IMAGE} as hsac-fixtures
RUN mkdir -p /fitnesse/wiki/fixtures/nl/hsac/fitnesse

WORKDIR /fitnesse

RUN mkdir target
VOLUME /fitnesse/target

RUN mkdir wiki/FitNesseRoot
VOLUME /fitnesse/wiki/FitNesseRoot

ENV FITNESSE_OPTS -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true
COPY test/runTests.sh .
COPY test/rerunFailedTests.sh .
COPY test/htmlReportIndexGenerator.sh .

ENTRYPOINT ["/fitnesse/runTests.sh"]
CMD []

COPY --from=base /usr/src/test/wiki wiki/


# ========== TEST-WITH-PDF ===========
FROM base as base-with-pdf
ARG VERSION
RUN mvn compile -P withPdf -Dhsac.fixtures.version=${VERSION}

FROM hsac-fixtures as hsac-fixtures-with-pdf
COPY --from=base-with-pdf /usr/src/test/wiki/fixtures wiki/fixtures


# ========== CHROME ===========
FROM ${SELENIUM_IMAGE} as hsac-chrome
RUN sudo mv /etc/supervisor/conf.d/selenium.conf /etc/supervisor/conf.d/selenium.conf.bak && \
    sudo mkdir -p /fitnesse/target && \
    sudo mkdir -p /fitnesse/wiki/webdrivers && \
    sudo ln -s /usr/bin/chromedriver /fitnesse/wiki/webdrivers/chromedriver-linux-64bit && \
    sudo chown -R 1200:1201 /fitnesse/

WORKDIR /fitnesse
COPY chrome/startGridAndRunTests.sh .
COPY chrome/fitnesse-hsac.conf /etc/supervisor/conf.d/

VOLUME /fitnesse/target
VOLUME /fitnesse/wiki/FitNesseRoot

ENV FITNESSE_OPTS -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true \
    -DseleniumBrowser=chrome \
    -DseleniumJsonProfile="{'args':['disable-dev-shm-usage','--remote-allow-origins=*']}"

ENTRYPOINT ["/fitnesse/startGridAndRunTests.sh"]
CMD []

COPY --from=hsac-fixtures --chown=1200:1201 /fitnesse /fitnesse


# ========== CHROME-WITH-PDF ===========
FROM hsac-chrome as hsac-chrome-with-pdf
COPY --from=hsac-fixtures-with-pdf /fitnesse/wiki/fixtures /fitnesse/wiki/fixtures


# ========== COMBINE ===========
FROM ${GRAALVM_IMAGE} as graal-fitnesse
RUN mkdir -p /fitnesse/target

WORKDIR /fitnesse

COPY --from=base /usr/src/combine/target/hsac-html-report-generator.jar target/
ENV JAVA_TOOL_OPTIONS="-Djdk.lang.Process.launchMechanism=vfork"
RUN native-image -jar target/hsac-html-report-generator.jar --static

FROM ${BUSYBOX_IMAGE} as combine
WORKDIR /fitnesse
VOLUME /fitnesse/target

ENTRYPOINT ["/fitnesse/hsac-html-report-generator"]
CMD []

COPY --from=graal-fitnesse /fitnesse/hsac-html-report-generator .
