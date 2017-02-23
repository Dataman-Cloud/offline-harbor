#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir

list=`ls *.tar`

for l in $list;do
	docker load -i $l || echo "load $l images"
done
