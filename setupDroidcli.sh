#!/bin/bash

cwd=$(pwd)

echo $cwd

cd ~/chrono/github/monorepo

git pull

gcloud auth login --update-adc

make droidcli

droidcli auth assume-role -r cluster-admin -c prod-test 

cd $cwd

echo "done"