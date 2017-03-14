#!/bin/bash
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir

docker-compose -p dataman down
deadids=`docker ps -aq --filter "STATUS=dead"`
if [ ! -z "$deadids" ];then
        docker rm -f $deadids
fi
