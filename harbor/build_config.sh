#!/bin/bash

set -eu

. ../config.cfg

#export LC_CTYPE=C

replace_var(){
    files=$@
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_HOST--#'$HARBOR_MYSQL_HOST'#g'
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_PORT--#'$HARBOR_MYSQL_PORT'#g'
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_USR--#'$HARBOR_MYSQL_USR'#g'
    echo $files | xargs sed -i 's#--HARBOR_MYSQL_PWD--#'$HARBOR_MYSQL_PWD'#g'
    echo $files | xargs sed -i 's#--HARBOR_SERVICE_IP--#'$HARBOR_SERVICE_IP'#g'
    echo $files | xargs sed -i 's#--HARBOR_ADMIN_PASSWORD--#'$HARBOR_ADMIN_PASSWORD'#g'
}

preconfigserver_conf(){
    rm -rf conf_d_tmp
    cp -rf conf_d.temp conf_d_tmp

    files=`grep -rl '' conf_d_tmp/*`
    replace_var $files

    rm -rf conf.d
    mv conf_d_tmp conf.d
}

preconfigserver_conf
