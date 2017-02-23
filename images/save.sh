#!/bin/bash
set -e

base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ../config.cfg

docker_images_save(){
	docker save -o $1 $2 && \
	echo "$2 save image file is succsee !!" || \
	echo "$2 save image file is fail !!"

}

main(){
	docker_images_save registry.tar $IMAGE_REGISTRY && \
	docker_images_save nginx.tar $IMAGE_NGINX && \
	docker_images_save mysql.tar $IMAGE_MYSQL && \
	docker_images_save harbor_ui.tar $IMAGE_HARBOR_UI && \
	docker_images_save harbor_job.tar $IMAGE_HARBOR_JOB
		
}
main
