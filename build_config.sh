#!/bin/bash
set -e
#export LC_CTYPE=C

set -eu

. ./config.cfg
IMAGE_LIST_FILE_PATH='../offlinesry/imagelist.txt'
if [ ! -f "$IMAGE_LIST_FILE_PATH" ];then
	echo "imagelist.txt not exist,pls check!!"
	exit 1
fi

replace_var(){
    files=$@
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_USR--#'$HARBOR_MYSQL_USR'#g'
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_PWD--#'$HARBOR_MYSQL_PWD'#g'
    echo $files | xargs sed -i 's#--HARBOR_SERVICE_IP--#'$HARBOR_REGISTRY_IP'#g'
    echo $files | xargs sed -i 's#--HARBOR_DOMAIN--#'$HARBOR_HARBOR_IP'#g'
    echo $files | xargs sed -i 's#--HARBOR_ADMIN_PASSWORD--#'$HARBOR_ADMIN_PASSWORD'#g'
}

create_conf(){
    rm -rf conf_d_tmp
    cp -rf conf_d.temp conf_d_tmp

    files=`grep -rl '' conf_d_tmp/*`
    replace_var $files

    rm -rf conf.d
    mv conf_d_tmp conf.d
}

# change images func
change_images(){
        IMAGE=$(jq ."$1"  $IMAGE_LIST_FILE_PATH | sed 's/\"//g'|sed 's/\//\\\//g')
        IMAGEx="--$1--"
        sed -i 's#'$IMAGEx'#'$REGISTRY_URL/$IMAGE'#g' $2
}

create_compose_file(){
	HARBOR_FILE="./docker-compose.yml"
	if [ -f $HARBOR_FILE ];then
        	rm -rf $HARBOR_FILE
	fi
	cp $HARBOR_FILE.templ $HARBOR_FILE && \
	sed -i 's/--harbor_ip--/'$HARBOR_HARBOR_IP'/g'  docker-compose.yml && \

	IMAGES_NAME=$(jq 'keys' $IMAGE_LIST_FILE_PATH | grep \" | sed 's/\"//g' |sed 's/,//g')
	for image in $IMAGES_NAME
	do
        	change_images $image $HARBOR_FILE
	done
}

main(){
	create_conf
	create_compose_file
}
main
