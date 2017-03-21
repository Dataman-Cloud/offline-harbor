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

# setting compose
if [ -f docker-compose.yml ];then
        rm -rf docker-compose.yml
fi
cp docker-compose.yml.conf docker-compose.yml && \
sed -i 's/--harbor_ip--/'$HARBOR_HARBOR_IP'/g'  docker-compose.yml && \

# run server    
export COMPOSE_HTTP_TIMEOUT=300
docker-compose -p dataman up -d
