#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ./config.cfg

# Export harbor system images
#./images/save.sh

# Import harbor system images
#./images/load.sh

# create config
./build_config.sh

# run server    
export COMPOSE_HTTP_TIMEOUT=300
docker-compose -p dataman up -d
