#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ./config.cfg

# build image
#./images/save.sh
#./images/load.sh

# build config
./build_config.sh

# run server    
export COMPOSE_HTTP_TIMEOUT=300
docker-compose -p dataman up -d
