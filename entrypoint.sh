#!/bin/sh

if [ ! -f /data/DOWNLOADED ]; then
    wget $OSM_DOWNLOAD_URL -O /data/map.osm.pbf && touch /data/DOWNLOADED
fi
if [ ! -f /data/EXTRACTED ]; then
    osrm-extract -p /profiles/$OSM_PROFILE /data/map.osm.pbf
    if [ $? -eq 0 ]; then
        touch /data/EXTRACTED
        rm -f /data/map.osm.pbf
    fi
fi
if [ ! -f /data/PARTITIONED ]; then
    osrm-partition /data/map.osrm && touch /data/PARTITIONED
fi
if [ ! -f /data/CUSTOMIZED ]; then
    osrm-customize /data/map.osrm && touch /data/CUSTOMIZED
fi

# Exec the CMD
exec "$@"