#!/bin/bash

. ../config.cfg

./mysql_add_user.sh $HARBOR_MYSQL_USR $HARBOR_MYSQL_PWD registry

tables_num=`mysql -u$HARBOR_MYSQL_USR -p$HARBOR_MYSQL_PWD -h$HARBOR_MYSQL_HOST -e "show databases"|grep registry|wc -l`
if [ $tables_num -eq 0 ];then
	mysql -u$HARBOR_MYSQL_USR -p$HARBOR_MYSQL_PWD -h$HARBOR_MYSQL_HOST < ./conf.d/db/registry.sql
fi
