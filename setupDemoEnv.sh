#!/bin/bash

#export CHRONOSPHERE_ORG_NAME=rc-collec
#export CHRONOSPHERE_API_TOKEN=37d84637cbd6d23

eval $(~/chrono/github/monorepo/scripts/set-chrono-env $1)

chronoctl preview service-accounts list
alias c=chronoctl