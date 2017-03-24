#!/bin/bash
set -e

base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ../config.cfg

rm -Rf *.tar


IMAGE_LIST_FILE_PATH="../../offlinesry/imagelist.txt"
IMAGE_REGISTRY=$(jq ."registry" $IMAGE_LIST_FILE_PATH | sed 's/\"//g')
IMAGE_NGINX=$(jq ."nginx" $IMAGE_LIST_FILE_PATH | sed 's/\"//g')
IMAGE_MYSQL=$(jq ."mysql" $IMAGE_LIST_FILE_PATH | sed 's/\"//g')
IMAGE_HARBOR_UI=$(jq ."harbor_ui" $IMAGE_LIST_FILE_PATH | sed 's/\"//g')
IMAGE_HARBOR_JOB=$(jq ."harbor_job" $IMAGE_LIST_FILE_PATH | sed 's/\"//g')


docker_images_save(){
        docker save -o $1 $2
        if [ $? -eq 0 ];then
                echo " save image $2 is succsee !"
        else
                echo " save image $2 is fail !"
                exit 1
        fi
}

main(){
	docker_images_save registry.tar $REGISTRY_URL'\'$IMAGE_REGISTRY && \
	docker_images_save nginx.tar $REGISTRY_URL'\'$IMAGE_NGINX && \
	docker_images_save mysql.tar $REGISTRY_URL'\'$IMAGE_MYSQL && \
	docker_images_save harbor_ui.tar $REGISTRY_URL'\'$IMAGE_HARBOR_UI && \
	docker_images_save harbor_job.tar $REGISTRY_URL'\'$IMAGE_HARBOR_JOB
}
main
