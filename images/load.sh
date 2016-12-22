#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir


docker images|grep -v grep|grep 'offlineregistry.dataman-inc.com:5000/library/centos7-docker-harbor' && exit 0 || echo "load harbor images"

list=`ls *.tar`

for l in $list;do
	docker load -i $l
done
