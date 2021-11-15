#!/bin/bash

###########################################
# A script to build Token Handler resources
###########################################

#
# Get and build the main Token Handler API (aka 'OAuth Agent')
#
cd ..
rm -rf bff-node-express
git clone https://github.com/curityio/bff-node-express token-handler-api
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the token handler API"
  exit 1
fi

cd token-handler-api
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

docker build -f Dockerfile -t token-handler-api:1.0.0 .
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API Docker file"
  exit 1
fi

#
# Get the 'OAuth Proxy', which is a simple reverse proxy plugin
#