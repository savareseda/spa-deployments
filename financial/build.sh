#!/bin/bash

######################################################################
# A script to build Token Handler resources in a financial-grade setup
######################################################################

#
# First generate OpenSSL certificates for development
#

#
# Get the main Token Handler API (aka 'OAuth Agent')
#
cd ..
rm -rf token-handler-api
git clone https://github.com/curityio/bff-node-express token-handler-api
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the token handler API"
  exit 1
fi

cd token-handler-api
git checkout non-blocking

#
# Build the Java code to a JAR file
#
./gradlew bootJar
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API's Java code"
  exit 1
fi

#
# Build the Java docker container
#
docker build -f Dockerfile -t token-handler-financial:1.0.0 .
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API Docker file"
  exit 1
fi

git checkout https://github.com/curityio/bff-node-express token-handler-api

#
# Get the 'OAuth Proxy', which is a simple reverse proxy plugin
#
