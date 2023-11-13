variable "VERSION" {
  default = "5.3.1"
}
variable "SELENIUM_VERSION" {
  default = "latest"
}
variable "TAG" {
  default = "latest"
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {}

group "default" {
  targets = ["base", "test", "test-with-pdf", "chrome", "chrome-with-pdf", "combine"]
}

target "base" {
  inherits = ["docker-metadata-action"]
  context = "."
  dockerfile = "Dockerfile"
  pull = true
  args = {
    VERSION = "${VERSION}"
  }
  tags = ["hsac/fitnesse-fixtures-test-jre11:base-${TAG}"]
}

target "test" {
  inherits = ["docker-metadata-action"]
  context = "test"
  dockerfile = "Dockerfile"
  pull = true
  contexts = {
    base = "target:base"
    jre = "docker-image://eclipse-temurin:11-jre"
  }
  tags = ["hsac/fitnesse-fixtures-test-jre11:${TAG}"]
}

target "test-with-pdf" {
  inherits = ["docker-metadata-action"]
  context = "test-with-pdf"
  dockerfile = "Dockerfile"
  contexts = {
    base = "target:base"
    hsac-fixtures = "target:test"
  }
  tags = ["hsac/fitnesse-fixtures-test-jre11-with-pdf:${TAG}"]
}

target "chrome" {
  inherits = ["docker-metadata-action"]
  context = "chrome"
  dockerfile = "Dockerfile"
  pull = true
  contexts = {
    selenium = "docker-image://seleniarm/standalone-chromium:${SELENIUM_VERSION}"
    hsac-fixtures = "target:test"
  }
  tags = ["hsac/fitnesse-fixtures-test-jre11-chrome:${TAG}"]
}

target "chrome-with-pdf" {
  inherits = ["docker-metadata-action"]
  context = "chrome-with-pdf"
  dockerfile = "Dockerfile"
  contexts = {
    test-with-pdf = "target:test-with-pdf"
    hsac-chrome = "target:chrome"
  }
  tags = ["hsac/fitnesse-fixtures-test-jre11-chrome-with-pdf:${TAG}"]
}

target "combine" {
  inherits = ["docker-metadata-action"]
  context = "combine"
  dockerfile = "Dockerfile"
  pull = true
  contexts = {
    base = "target:base"
    graal = "docker-image://ghcr.io/graalvm/native-image:latest"
    busybox = "docker-image://busybox:latest"
  }
  tags = ["hsac/fitnesse-fixtures-combine:${TAG}"]
}
