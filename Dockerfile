ARG  MAVEN_VERSION=3.5.3-jdk-8-alpine
FROM maven:${MAVEN_VERSION} as build
RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY pom.xml .

RUN mvn compile

COPY src/ ./src

RUN mvn compile
