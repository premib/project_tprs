#!/bin/bash

#stop running containers
docker-compose -f docker-compose-cli.yaml down --volumes --remove-orphan

#remove certs and channel configs
rm -rf channel-artifacts/*.block channel-artifacts/*.tx crypto-config

#remove containers
CONT_ID=$(docker ps -a | awk '($2 ~ /dev-peer.*/) {print $1}')
if [ -z "$CONT_ID" -o "$CONT_ID" == " " ]; then
echo "############# NO CONTAINERS AVAILABLE FOR DELETION #############"
else
docker rm -f $CONT_ID
fi


#delete unwanted images 
IMG_ID=$(docker images | awk '($1 ~ /dev-peer.*/) {print $3}')
if [ -z "$IMG_ID" -o "$IMG_ID" == " " ]; then
    echo "############# NO IMAGES AVAILABLE FOR DELETION #############"
else
    docker rmi -f $IMG_ID
fi