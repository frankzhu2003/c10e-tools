#!/bin/bash

cwd=$(pwd)

echo $cwd

cd ./opentelemetry-demo

git pull

sudo make build-and-push-dockerhub

cd $cwd

echo "done"