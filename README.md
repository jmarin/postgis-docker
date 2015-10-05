# postgis-docker
Docker image for Postgis

## Introduction

Docker image for the geospatial extension to PostgreSQL, [Postgis](http://postgis.net/). 
This image extends from `jmarin\supervisor`, see its definition [here](https://github.com/jmarin/supervisor-docker.git)
PostgreSQL runs under [supervisord](http://supervisord.org/), restarting if there is a problem. By default the database is configured with user `docker` and password `docker`. 

The docker image is configured to run on port 5432 and listen from local ip addresses. These settings can be changed before building the image in the [Dockerfile](https://github.com/jmarin/postgis-docker/blob/master/Dockerfile)

## Building and running

Two scripts are provided for convenience. The first one, `build.sh`, builds the docker image locally. The second, `run.sh`, runs a container on port 5432. Both can be adapted with additional options or different defaults, and they can also serve as documentation on how to build and run the container. 

This Postgis image pulls its dependencies from the OpenGeo repository, and should have all necessary dependencies for an RPM distro (RHEL, CentOS)

