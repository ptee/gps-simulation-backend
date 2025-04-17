# Extension of OSRM Backend For Route Planning and Simulation Part 1.

[OSRM Routing Service](https://github.com/Project-OSRM/osrm-backend) is a high-performance routing engine that runs on OpenStreetMap data. This component is responsible for defining routing preferences for each vehicle type used by the [Simulation Core]().


## Download OSM Map
- Download OSM map or use pbf from Geofabrik e.g. germany-latest.osm.pbf (3.4GB):

`wget http://download.geofabrik.de/europe/germany/germany-latest.osm.pbf`


## OSRM Backend 
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

`osrm-contract germany-latest.osrm` <br>


4. Start the routing server on port 5001 where "our websocket" is listening: <br>

`osrm-routed --algorithm=mld -p 5001 germany-latest.osrm` <br>


## Tractor/HGV Profiles
This repository includes three tractor profiles:

- Tractor limited to 10 tons
- Tractor heavier than 10 tons
- a standard car.


## Using Docker

Both [osrm-backend](https://hub.docker.com/r/osrm/osrm-backend) and [osrm-frontend](https://hub.docker.com/r/osrm/osrm-frontend) Docker images are available from [official Docker Hub](https://hub.docker.com/). When using Docker, the map is downloaded and prepared automatically on the first run. 
Just specify the map URL and the profile name in the **map.env**:

```inf
OSM_DOWNLOAD_URL=http://download.geofabrik.de/europe/germany/niedersachsen-latest.osm.pbf
OSM_PROFILE=tractor10t.lua
```

### Build the Docker image:
`docker build --pull --rm -t gps-simulation-backend:latest .`

### Run the Docker image:
`docker run -d --rm -p 5001:5000 -v niedersachsen-osm:/data --env-file map.env --name gps-simulation-backend gps-simulation-backend:latest`

You can then access the OSRM endpoint at **http://localhost:5001**

If you later change the map URL, be sure to change the volume name `-v XXX:/data` in the run command. Otherwise, Docker will continue using the previously downloaded map.
To save space, you can delete the old volume if it's no longer needed:

`docker volume rm niedersachsen-osm`

-------------------
