FROM osrm/osrm-backend:latest

RUN apt-get update && apt-get install wget -y

COPY ./profiles /profiles/
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "osrm-routed", "--algorithm=mld", "/data/map.osrm" ]
