#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
#./loadimage.sh
./images/load.sh
./build_config.sh
docker-compose -p dataman up -d
#./import_sql.sh
