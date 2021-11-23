#!/bin/bash

#####################################################################
# A script to build Token Handler resources for the standard scenario
#####1###############################################################

#
# Ensure that we are in the folder containing this script
#
cd "$(dirname "${BASH_SOURCE[0]}")"

#
# This is for Curity developers only
#
cp ../hooks/pre-commit ../.git/hooks

#
# Get and build the main Token Handler API (aka 'OAuth Agent')
#
rm -rf token-handler-api
git clone https://github.com/curityio/bff-node-express token-handler-api
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the token handler API"
  exit 1
fi

cd token-handler-api
git checkout dev
cp ../token-handler-api-config/config.ts ./src/

npm install
if [ $? -ne 0 ]; then
  echo "Problem encountered installing the Token Handler API dependencies"
  exit 1
fi

npm run build
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API code"
  exit 1
fi

docker build -f Dockerfile -t token-handler-standard:1.0.0 .
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API Docker file"
  exit 1
fi

#
# Get the 'OAuth Proxy', which is a simple reverse proxy plugin
#
cd ..
rm -rf kong-bff-plugin
git clone https://github.com/curityio/kong-bff-plugin
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the BFF plugin"
  exit 1
fi

#
# Also download the phantom token plugin for the reverse proxy
#
rm -rf kong-phantom-token-plugin
git clone https://github.com/curityio/kong-phantom-token-plugin
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the phantom token plugin"
  exit 1
fi