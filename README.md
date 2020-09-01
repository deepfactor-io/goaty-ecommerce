# Goaty Ecommerce App
Vulnerable Ecommerce App made of components like Redis and  Django

## Warning
This application is a Vulnerable Web Application.
Please make sure it is not deployed on Production Environments, Public facing servers or Critical Infrastructure.
Please use it at your own risk.
We have made it clear that the application should not be used maliciously.

## Prerequisites
- docker
- kubernetes
- helm
- nginx running in kubernetes

## Build Docker Images
```
scripts/build-microservices.sh <DOCKER_REPO> <HOSTDOMAIN> <VERSION>
```

## Install Microservices 
```
scripts/install-microservices.sh <DOCKER_REPO> <NAMESPACE> <HOSTDOMAIN> <VERSION>
```
