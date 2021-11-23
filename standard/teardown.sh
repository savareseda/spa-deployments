#!/bin/bash

#########################################################################
# A simple script to free Docker resources when finished with development
#########################################################################

#
# Ensure that we are in the folder containing this script
#
cd "$(dirname "${BASH_SOURCE[0]}")"

#
# The standard token handler does not use detached mode so there is nothing to do
#