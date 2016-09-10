#!/bin/bash
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
./build_config.sh
./import_sql.sh
docker-compose -p harbor_registry up -d
