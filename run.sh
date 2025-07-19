#!/bin/bash
set -e
docker rm -f dev-container
docker build -t dev-container .
docker run --name dev-container -it -v $HOME/.ssh:/root/.ssh:ro -v ./workdir:/workdir -v ./nvim:/root/.config/nvim dev-container