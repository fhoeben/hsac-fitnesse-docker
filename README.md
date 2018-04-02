This docker image project creates images to run test using FitNesse and the baseline provided by [hsac-fitnesse-fixtures](https://github.com/fhoeben/hsac-fitnesse-fixtures).

The docker images allow tests to be run from inside a docker container.

The tests to be run are expected to be supplied by a volume mounted to `/fitnesse/wiki/FitNesseRoot`. 
Test results will be written to `/fitnesse/target`, in surefire xml format (in `/fitnesse/target/failsafe-reports`) and in HTML (in `/fitnesse/target/fitnesse-rersults`).
By mounting a volume the host running the container can access these results after the test run is completed.

There is a base image: hsac/fitnesse-fixtures-test-jre8, which just contains a JRE, FitNesse and hsac fixtures.

And there is an image, based on Selenium's standalone chrome one: hsac/fitnesse-fixtures-test-jre8-chrome, which also contains a local Chrome browser and is configured to have BrowserTest use that.
The image which contains Chrome also exposes its Selenium log (in `/fitnesse/target/selenium-log`).

Both images are preconfigured to start a FitNesse run immediately when started and you are expected to supply a suite to run using a system property value for 'fitnesseSuiteToRun'
(e.g. `-DfitnesseSuiteToRun=SampleTests.SlimTests.UtilityFixtures`).

Samples on how use the images can be found in this repo's `buildTest.sh` and `buildChrome.sh` scripts, which after building the images also run a container based on the newly 
created image (using wiki content from `src/main/wiki`). 

The images also contain a script to combine test results from multiple test runs in a single report: `htmlReportIndexGenerator.sh`.
This script can be invoked using `docker run` by changing the entrypoint of either of the images to this script and mounting the fitnesse-results created by individual runs.
A sample of how to do this can be found in this repo's `combineReports.sh`. 
