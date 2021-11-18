#!/bin/bash

############################################################################
# A script to build Token Handler resources for the financial-grade scenario
############################################################################

#
# This is for Curity developers only
#
cp ../hooks/pre-commit ../.git/hooks

#
# Generate OpenSSL certificates for development
#
if [ ! -f './certs/example.ca.p12' ]; then
  cd certs
  ./create-certs.sh
  if [ $? -ne 0 ]; then
    echo "Problem encountered downloading the token handler API"
    exit 1
  fi
  cd ..
fi

#
# Get and build the main Token Handler API (aka 'OAuth Agent')
#
rm -rf token-handler-api
git clone https://github.com/curityio/token-handler-kotlin-spring-fapi token-handler-api
if [ $? -ne 0 ]; then
  echo "Problem encountered downloading the token handler API"
  exit 1
fi

cd token-handler-api
git checkout non-blocking-deployment
cp ../token-handler-api-config/application.yml ./src/main/resources/

./gradlew bootJar
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API's Java code"
  exit 1
fi

docker build -f Dockerfile -t token-handler-financial:1.0.0 .
if [ $? -ne 0 ]; then
  echo "Problem encountered building the Token Handler API Docker file"
  exit 1
fi

#
# Build a temporary image to enable HTTP debugging
#
cd ../reverse-proxy
docker build -f Dockerfile -t custom-kong:2.5.0-alpine .

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