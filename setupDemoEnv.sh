#!/bin/bash

#export CHRONOSPHERE_ORG_NAME=rc-collec
#export CHRONOSPHERE_API_TOKEN=37d84637cbd6d23

gcloud auth login --update-adc
droidcli auth assume-role -r cluster-admin -c prod-test 

eval $(~/chrono/github/monorepo/scripts/set-chrono-env $1)

chronoctl preview service-accounts list
alias c=chronoctl

echo "CHRONOSPHERE_ORG_NAME=$CHRONOSPHERE_ORG_NAME"
echo "CHRONOSPHERE_API_TOKEN=$CHRONOSPHERE_API_TOKEN"