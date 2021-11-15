#!/bin/bash

###################################################################
# A script to deploy Token Handler resources for the basic scenario
###################################################################

#
# First check prerequisites
#
if [ ! -f './idsvr/license.json' ]; then
  echo "Please provide a license.json file in the deployment/idsvr folder in order to deploy the system"
  exit 1
fi

#
# Spin up all containers, using the Docker Compose file, which applies the deployed configuration
#
docker compose --project-name spa up --force-recreate
if [ $? -ne 0 ]; then
  echo "Problem encountered starting Docker components"
  exit 1
fi
