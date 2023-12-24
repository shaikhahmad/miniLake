#!/bin/bash

docker build --no-cache -t ahmad/minilake:hadoop331 ./base
docker build --no-cache -t ahmad/minilake-master:hadoop331 ./master
docker build --no-cache -t ahmad/minilake-worker:hadoop331 ./worker
docker build --no-cache -t ahmad/minilake-history:hadoop331 ./history
docker build --no-cache -t ahmad/minilake-jupyter:hadoop331 ./jupyter
