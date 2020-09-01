#!/bin/bash

if [ $# -lt 3 ]; then
  echo 1>&2 "Usage: $0 <DOCKER_REPO> <HOSTDOMAIN> <VERSION>"
  exit 2
fi
DOCKER_REPO=$1
HOSTDOMAIN=$2
VERSION=$3

cd ./apps/redis/docker ; docker build -t redis -f Dockerfile . 
if [[ $? -ne 0 ]] ; then
    echo "error docker build redis"
    exit 1
fi
cd ../../../

cd ./apps/webappdjango/docker ; docker build --build-arg HOSTDOMAIN=${HOSTDOMAIN} -t webappdjango -f Dockerfile . 
if [[ $? -ne 0 ]] ; then
    echo "error docker build webappdjango"
    exit 1
fi

docker tag redis ${DOCKER_REPO}/redis:${VERSION} && docker push ${DOCKER_REPO}/redis:${VERSION}
if [[ $? -ne 0 ]] ; then
    echo "error tagging/pushing redis"
    exit 1
fi

docker tag webappdjango ${DOCKER_REPO}/webappdjango:${VERSION} && docker push ${DOCKER_REPO}/webappdjango:${VERSION}
if [[ $? -ne 0 ]] ; then
    echo "error tagging/pushing webappdjango"
    exit 1
fi

