ARG MAVEN_VERSION=3.8-amazoncorretto-11
FROM maven:${MAVEN_VERSION} as build
ARG VERSION=5.3.0
RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY pom.xml .

RUN mvn compile -Dhsac.fixtures.version=${VERSION}

COPY src/ ./src

RUN mvn package -Dhsac.fixtures.version=${VERSION}
