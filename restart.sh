#!/usr/bin/env bash

appName=app

docker-compose exec -T ${appName} pkill -1 ${appName}
