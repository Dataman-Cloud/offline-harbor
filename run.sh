#!/bin/bash
set -e
. ./config.cfg
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
#./loadimage.sh
./images/load.sh
./build_config.sh
if [ -f docker-compose.yml ];then
        rm -rf docker-compose.yml
fi
cp docker-compose.yml.conf docker-compose.yml && \
sed -i 's/--harbor_ip--/'$HARBOR_HARBOR_IP'/g'  docker-compose.yml && \
docker-compose -p dataman up -d
#./import_sql.sh
