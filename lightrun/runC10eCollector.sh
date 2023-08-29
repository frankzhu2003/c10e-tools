#!/bin/bash

GATEWAY_ADDRESS=demo-sandbox.chronosphere.io:443 API_TOKEN=$API_TOKEN nohup ./chronocollector-linux-amd64 -f ~/github/c10e-tools/lightrun/config.yml &