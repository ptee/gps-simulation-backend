<<<<<<< HEAD
# Extension of OSRM Backend For Route Planning and Simulation Part 1.

[OSRM Routing Service](https://github.com/Project-OSRM/osrm-backend) is a high-performance routing engine that runs on OpenStreetMap data. This component is responsible for defining routing preferences for each vehicle type used by the [Simulation Core]().


## Download OSM Map
- Download OSM map or use pbf from Geofabrik e.g. germany-latest.osm.pbf (3.4GB):
=======
# Extension of OSRM Backend As Part of Agri-GAIA WP 5.1 Route Planning and Simulation Part 1.

This code is part of the [Agri-GAIA](https://www.agri-gaia.de/) Work Package 5.1 as part of [GAIA-X](https://www.gaia-x.eu/) responsible by [AgBrain](https://agbrain.de). <br>

WP 5.1 Part 1 (GPS Simulation between inter-fields) consists of the following modules:

- [OSRM routing service](https://github.com/Project-OSRM/osrm-backend) acts as the routing service for the project. This module is served as the extension of the OSRM routing service for tracktors.

- [Simulation Core](https://git.cci-net.de/agri-gaia/gps-simulation) is the core simulation.

- [Web frontend](https://git.cci-net.de/agri-gaia/gps-simulation-frontend). Not part of Agri-Gaia project and the code may not be delivered. It's AgBrain demo server. 

## Download OSM Map

- Download OSM map or pbf from Geofabrik e.g. germany-latest.osm.pbf (3.4GB) or
>>>>>>> f95b5eb (initial add file)

`wget http://download.geofabrik.de/europe/germany/germany-latest.osm.pbf`


## OSRM Backend 
<<<<<<< HEAD
You can either:
- Download and build the OSRM backend source from [OSRM Project](https://github.com/Project-OSRM/osrm-backend).

Or:
- Pull the official [OSRM Docker Image](https://hub.docker.com/r/osrm/osrm-backend) from the [official docker hub](https://hub.docker.com/).

## Extracting Routes for tractor:

1. Extract the routing graph from the OSM base map for MLD (Multi-Level Dijkstra) pipeline using the "tractor profile (limited to 10 ton)" <br>

`osrm-extract germany-latest.osm.pbf -p profiles/tractor10t.lua`

2. Partition the graph for use with MLD, <br>

`osrm-partition germany-latest.osrm`

3. Customize the cells by calculating routing weights. <br>

`osrm-customize germany-latest.osrm` <br>

For the Contraction Hierachies (CH) algorithm, use: <br>
=======

Either:
- Download the OSRM backend source from https://github.com/Project-OSRM/osrm-backend  and build the binary

Or:
- Pull the [OSRM-image](https://hub.docker.com/r/osrm/osrm-backend) from the [official docker hub](https://hub.docker.com/).

## Route extract for tractor:

1. Extract a graph out of OSM base map for MLD pipeline with the "tractor with limit of 10 ton" profile. <br>

`osrm-extract germany-latest.osm.pbf -p profiles/tractor10t.lua`

2. Partition the graph recursively into cells, <br>

`osrm-partition germany-latest.osrm`

3. Customize the cells by calculating routing weights for all cells. <br>

`osrm-customize germany-latest.osrm` <br>

Or for Contraction Hierachies (CH) algorithm, after extract the base map we call: <br>
>>>>>>> f95b5eb (initial add file)

`osrm-contract germany-latest.osrm` <br>


<<<<<<< HEAD
4. Start the routing server on port 5001 where "our websocket" is listening: <br>
=======
4. Run the routing server at port 5001 where "our websocket" is listening: <br>
>>>>>>> f95b5eb (initial add file)

`osrm-routed --algorithm=mld -p 5001 germany-latest.osrm` <br>


## Tractor/HGV Profiles
<<<<<<< HEAD
This repository includes three tractor profiles:

- Tractor limited to 10 tons
- Tractor heavier than 10 tons
- a standard car.
=======

We use the tractor profiles to build the OSM files. Two tractor profiles, "tractor with limit weight of 10 ton" and "tractor with weight more than 10 ton" are available along with "car profile" in this repository.
>>>>>>> f95b5eb (initial add file)


## Using Docker

<<<<<<< HEAD
Both [osrm-backend](https://hub.docker.com/r/osrm/osrm-backend) and [osrm-frontend](https://hub.docker.com/r/osrm/osrm-frontend) Docker images are available from [official Docker Hub](https://hub.docker.com/). When using Docker, the map is downloaded and prepared automatically on the first run. 
Just specify the map URL and the profile name in the **map.env**:
=======
OSRM images, [osrm-backend](https://hub.docker.com/r/osrm/osrm-backend) and [osrm-frontend](https://hub.docker.com/r/osrm/osrm-frontend), are available at the [official docker hub](https://hub.docker.com/). When using the docker image, the map is downloaded and prepared automatically on the first run. 
Just set the URL of the map and the profile name in map.env:
>>>>>>> f95b5eb (initial add file)

```inf
OSM_DOWNLOAD_URL=http://download.geofabrik.de/europe/germany/niedersachsen-latest.osm.pbf
OSM_PROFILE=tractor10t.lua
```

<<<<<<< HEAD
### Build the Docker image:
`docker build --pull --rm -t gps-simulation-backend:latest .`

### Run the Docker image:
`docker run -d --rm -p 5001:5000 -v niedersachsen-osm:/data --env-file map.env --name gps-simulation-backend gps-simulation-backend:latest`

You can then access the OSRM endpoint at **http://localhost:5001**

If you later change the map URL, be sure to change the volume name `-v XXX:/data` in the run command. Otherwise, Docker will continue using the previously downloaded map.
To save space, you can delete the old volume if it's no longer needed:

`docker volume rm niedersachsen-osm`

-------------------
=======
For building the docker image run:<br>
`docker build --pull --rm -t gps-simulation-backend:latest .`

For running the build image run:<br>
`docker run -d --rm -p 5001:5000 -v niedersachsen-osm:/data --env-file map.env --name gps-simulation-backend gps-simulation-backend:latest`

After that you can reach the OSRM endpoint on localhost:5001

When changing the map URL later on, make sure to change the name of the volume in the run command `-v XXX:/data`, because otherwise it will continue to use the previously downloaded map. If you won't use the previous map again, delete the old volume to save disk space:
`docker volume rm niedersachsen-osm`

-------------------
>>>>>>> f95b5eb (initial add file)
