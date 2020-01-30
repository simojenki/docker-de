#!/bin/bash

docker rmi --force simojenki/xfce:latest
docker build --pull -t simojenki/xfce:latest .
