#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..
VERSION=${1:-latest}
PROJECT=compose

REPORT_DIR=${BASEDIR}/target/fitnesse-results
COMBINE_IMAGE=hsac/fitnesse-fixtures-test-jre8:${VERSION}

COMPOSE_CMD="docker-compose -f docker-compose.yml"

SUITES=( test test-with-pdf chrome chrome-with-pdf chrome-suffix chrome-with-pdf-suffix )

main() {
    cleanup

    export VERSION

    for SUITE in "${SUITES[@]}"
    do
        prepareContainer ${SUITE}
    done

    showProgress

    echo "Tests completed, copying results from containers"

    mkdir -p ${REPORT_DIR}
    mkdir -p ${BASEDIR}/target/failsafe-reports

    for SUITE in "${SUITES[@]}"
    do
        getResultsFromContainer ${SUITE}
    done

    echo "Combining test results"
    if [[ -d ${BASEDIR}/target/fitnesse-results ]]; then
        combineReports
    else
        echo "No FitNesse results available"
    fi

    for SUITE in "${SUITES[@]}"
    do
        checkExitCode ${SUITE}
    done

    stopAndRemoveAll
}

cleanup() {
    rm -rf ${BASEDIR}/target
    stopAndRemoveAll
}

copyWiki() {
    CONTAINER=${PROJECT}_$1_1

    echo "Copying tests to ${CONTAINER}"
    docker cp ${BASEDIR}/src/main/wiki/. ${CONTAINER}:/fitnesse/wiki/FitNesseRoot
}

prepareContainer() {
    SUITE=$1
    ${COMPOSE_CMD} up --no-start ${SUITE}
    copyWiki ${SUITE}
    ${COMPOSE_CMD} up -d ${SUITE}
}

showProgress() {
    echo "Showing test progress"

    var=0;
    for SUITE in "${SUITES[@]}"; do
        CONTAINER=${PROJECT}_${SUITE}_1
        if [[ "$(docker ps -a | grep ${CONTAINER})" ]]; then
            echo "Starting tail of ${CONTAINER}"
            # run processes and store pids in array
            docker logs -f ${CONTAINER} | sed 's/^/'"${SUITE}"': /' &
            ((++var))
            PIDS[${var}]=$!
        else
            echo "No container ${CONTAINER}"
        fi
        ((++var))
        CONTAINERS[${var}]=${CONTAINER}
    done

    # wait for all pids
    for PID in ${PIDS[*]}; do
        wait ${PID}
    done
}

getResultsFromContainer() {
    SUITE=$1
    CONTAINER=${PROJECT}_$1_1

    TARGET_DIR=${BASEDIR}/target/${SUITE}
    echo "Copying test results from container ${SUITE} to ${TARGET_DIR}"
    docker cp ${CONTAINER}:/fitnesse/target/. ${TARGET_DIR}

    mv ${TARGET_DIR}/fitnesse-results ${REPORT_DIR}/${SUITE}
    if [[ -f "${TARGET_DIR}/fitnesse-rerun-results" ]]; then
        mv ${TARGET_DIR}/fitnesse-rerun-results ${REPORT_DIR}/${SUITE}-rerun
    fi
    cp -r ${TARGET_DIR}/failsafe-reports/. ${BASEDIR}/target/failsafe-reports/.

    docker logs ${CONTAINER} &> ${BASEDIR}/target/fitnesse-${SUITE}.docker.log

    if [[ -f "${TARGET_DIR}/selenium-log/selenium.log" ]]; then
        mv ${TARGET_DIR}/selenium-log/selenium.log ${BASEDIR}/target/selenium-${SUITE}.docker.log
    fi
}

combineReports() {
    CONTAINER_DIR=/fitnesse/target/fitnesse-results
    echo "Generating overview report in ${REPORT_DIR}"

    CONTAINER=${PROJECT}_combine-reports_1

    docker create --name ${CONTAINER} --entrypoint /fitnesse/htmlReportIndexGenerator.sh ${COMBINE_IMAGE}

    # Create CONTAINER_DIR in container
    chmod a+w ${REPORT_DIR}
    docker cp ${REPORT_DIR} ${CONTAINER}:/fitnesse/target/

    # Container creates overview combining results from each run
    docker start ${CONTAINER}
    docker logs -f ${CONTAINER}

    # Overview and full results from each run together will be artifact in Bamboo
    docker cp ${CONTAINER}:${CONTAINER_DIR}/. ${REPORT_DIR}/
    if [[ -f ${REPORT_DIR}/index.html ]]; then
        echo "Generated overview is saved as: ${REPORT_DIR}/index.html"
    fi
    docker rm -f -v ${CONTAINER}
}

checkExitCode() {
    CONTAINER=${PROJECT}_$1_1
    EXIT_CODE=`docker inspect ${CONTAINER} --format='{{.State.ExitCode}}'`
    if [[ ${EXIT_CODE} -ne 0 ]]; then
        echo "Will exit with exit code of fitnesse container '$1': ${EXIT_CODE}"
        stopAndRemoveAll
        exit ${EXIT_CODE}
    fi
}

stopAndRemoveAll() {
    ${COMPOSE_CMD} down
}

main
