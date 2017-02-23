#!/bin/bash
set -e

base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ../config.cfg

rm -Rf *.tar

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
	docker_images_save registry.tar $IMAGE_REGISTRY && \
	docker_images_save nginx.tar $IMAGE_NGINX && \
	docker_images_save mysql.tar $IMAGE_MYSQL && \
	docker_images_save harbor_ui.tar $IMAGE_HARBOR_UI && \
	docker_images_save harbor_job.tar $IMAGE_HARBOR_JOB
}
main
