Samples to run tests in parallel using docker-compose.

Two versions exists:
 * One using mounted volumes to send wiki contents to the containers and retrieve their results. 
 This is the easiest to setup can cause issues with permissions on Linux. `./runTestsAndCombine.sh`
 * One using `docker cp` to copy the wiki contents and retrieve the results.
 This is more hassle, but prevents the permission issue. `./runTestsAndCombineCp.sh`

They share the same `docker-compose.yml` file defining the services to start.
The `docker-compose.override.yml` is loaded by default by `docker-compose` and it defines the volumes to mount.
When using the 'cp-approach' we use `docker-compose -f docker-compose.yml` 
(explicitly defining which file to load and thereby) preventing the default behavior
 of also loading '.override', and so the volumes are not mounted.
 
 Results are stored in `../target` by both scripts.
