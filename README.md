This docker image project creates images to run test using FitNesse and the baseline provided by [hsac-fitnesse-fixtures](https://github.com/fhoeben/hsac-fitnesse-fixtures).

The docker images allow tests to be run from inside a docker container.

The tests to be run are expected to be supplied by a volume mounted to `/fitnesse/wiki/FitNesseRoot`. 
Test results will be written to `/fitnesse/target`, in surefire xml format (in `/fitnesse/target/failsafe-reports`) and in HTML (in `/fitnesse/target/fitnesse-rersults`).
By mounting a volume the host running the container can access these results after the test run is completed.