This docker image can run test using FitNesse and the baseline provided by [hsac-fitnesse-fixtures](https://github.com/fhoeben/hsac-fitnesse-fixtures).
Besides FitNesse hsac-fitnesse-fixtures it also contains a local Chrome browser (using [selenium/standalone-chrome](https://hub.docker.com/r/selenium/standalone-chrome/)) and is configured to have BrowserTest use that.
Its source can be found on [GitHub](https://github.com/fhoeben/hsac-fitnesse-docker).

The tests to be run are expected to be supplied by a volume mounted to `/fitnesse/wiki/FitNesseRoot`. 
Test results will be written to `/fitnesse/target`, in surefire xml format (in `/fitnesse/target/failsafe-reports`) and in HTML (in `/fitnesse/target/fitnesse-results`).
By mounting a volume the host running the container can access these results after the test run is completed.
It exposes its Selenium log (in `/fitnesse/target/selenium-log`).

The image is preconfigured to start a FitNesse run immediately when started and you are expected to supply a suite to run using a system property value for 'fitnesseSuiteToRun'
(e.g. `-DfitnesseSuiteToRun=SampleTests.SlimTests.UtilityFixtures`). Other system properties arguments can also be supplied as arguments to 'docker run'.

Samples on how use the image can be found in [this image's GitHub repo's `buildChrome.sh`](https://github.com/fhoeben/hsac-fitnesse-docker/blob/master/buildChrome.sh) script, which after building the image
also run a container based on the newly created image (using wiki content from `src/main/wiki`). 

The image also contain a script to combine test results from multiple test runs in a single report: `htmlReportIndexGenerator.sh`.
This script can be invoked using `docker run` by changing the entrypoint and mounting the fitnesse-results created by individual runs.
A sample of how to do this can be found in [this image's GitHub repo `combineReports.sh`](https://github.com/fhoeben/hsac-fitnesse-docker/blob/master/combineReports.sh). 
