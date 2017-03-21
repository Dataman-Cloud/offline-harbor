#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ./config.cfg

function check_port(){
	name=$1
	port=$2
	netstat -lntp |grep ":$port[[:space:]]" &>/dev/null && echo "$name is ok" || (echo "$name is error";exit 1)
}

check_port proxy-harbor 80
check_port proxy-registry 443
docker login -u admin -p Harbor12345 "$HARBOR_HARBOR_IP" | grep "Login Succeeded" &>/dev/null && echo "harbor and registry ok" && docker logout "$HARBOR_HARBOR_IP" &>/dev/null || (echo "harbor or registry error";exit 1)
