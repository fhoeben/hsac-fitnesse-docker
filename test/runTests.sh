#!/usr/bin/env sh

FITNESSE_CP=wiki/fixtures:wiki/fixtures/*

CMD="java -cp ${FITNESSE_CP} ${FITNESSE_OPTS} $@ nl.hsac.fitnesse.junit.JUnitConsoleRunner nl.hsac.fitnesse.HsacFitNesseSuiteStarter"
echo ${CMD}

${CMD}
