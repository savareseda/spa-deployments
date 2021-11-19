#!/bin/bash

###################################################################
# A script to deploy Token Handler resources for the basic scenario
###################################################################

#
# Ensure that we are in the folder containing this script
#
cd "$(dirname "${BASH_SOURCE[0]}")"

#
# First check prerequisites
#
if [ ! -f './idsvr/license.json' ]; then
  echo "Please provide a license.json file in the basic/idsvr folder in order to deploy the system"
  exit 1
fi

#
# Ensure that the token handler is updated with the scenario's configuration
#
cp ./token-handler-api-config/config.js ./token-handler-api/dist/config.js

#
# Spin up all containers, using the Docker Compose file, which applies the deployed configuration
#
docker compose --project-name spa up --force-recreate
if [ $? -ne 0 ]; then
  echo "Problem encountered starting Docker components"
  exit 1
fi
