#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir

function check_port(){
	name=$1
	port=$2
	netstat -lntp |grep $port &>/dev/null && echo "$name is ok" || (echo "$name is error";exit 1)
}

check_port proxy-harbor 80
check_port proxy-registry 443
docker login -u admin -p Harbor12345 127.0.0.1 | grep "Login Succeeded" &>/dev/null && echo "harbor and registry ok" && docker logout 127.0.0.1 &>/dev/null || (echo "harbor or registry error";exit 1)
