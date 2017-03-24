#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ./config.cfg

function install(){
	echo "######### init config ########"
	# create config
	./build_config.sh

	echo "######### install harbor ########"
	# run server    
	export COMPOSE_HTTP_TIMEOUT=300
	docker-compose -p dataman up -d
}

function check_port(){
	name=$1
	port=$2
	netstat -lntp |grep ":$port[[:space:]]" &>/dev/null && echo "$name is ok" || (echo "$name is error";exit 1)
}

function check(){
	echo "######### check harbor ########"
	check_port proxy-harbor 80
	check_port proxy-registry 443
	docker login -u admin -p "$HARBOR_ADMIN_PASSWORD" "$HARBOR_HARBOR_IP" | grep "Login Succeeded" &>/dev/null && echo "harbor and registry ok" && docker logout "$HARBOR_HARBOR_IP" &>/dev/null || (echo "harbor or registry error";exit 1)
}

main(){
	install
	check

	echo "------------------------------------------------------------"
	echo "Harbor addr: http://$HARBOR_HARBOR_IP"
	echo "Registry addr: $HARBOR_HARBOR_IP"
	echo "Default user: admin"
	echo "Default password : $HARBOR_ADMIN_PASSWORD"
	echo "------------------------------------------------------------"
}
main
