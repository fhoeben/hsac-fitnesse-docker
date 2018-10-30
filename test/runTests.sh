#!/usr/bin/env sh

FITNESSE_CP=wiki/fixtures:wiki/fixtures/*

CMD="java -cp ${FITNESSE_CP} ${FITNESSE_OPTS} $@ nl.hsac.fitnesse.junit.JUnitConsoleRunner nl.hsac.fitnesse.HsacFitNesseSuiteStarter"
echo ${CMD}
if [ "${RE_RUN_FAILED}" = "true" ]; then
    echo "An attempt will be made to rerun failed tests, should they occur."
fi

${CMD}

retVal=$?
if [ ${retVal} -ne 0 ]; then
    if [ -f '/fitnesse/wiki/FitNesseRoot/ReRunLastFailures.wiki' -a "${RE_RUN_FAILED}" = "true" ]; then
        echo "Rerunning failed tests"
        CMD="java -cp ${FITNESSE_CP} ${FITNESSE_OPTS} $@ -DfitnesseSuiteToRun=ReRunLastFailures nl.hsac.fitnesse.junit.JUnitConsoleRunner nl.hsac.fitnesse.HsacFitNesseSuiteStarter"
        echo ${CMD}
        ${CMD}
        exit $?
    fi
fi
exit ${retVal}
