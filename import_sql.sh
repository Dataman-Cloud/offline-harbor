#!/bin/bash
set -e
. ../config.cfg


../mysql_add_user.sh $SRY_MYSQL_ROOT_PASSWORD $HARBOR_MYSQL_HOST $HARBOR_MYSQL_USR $HARBOR_MYSQL_PWD registry $HARBOR_MYSQL_PORT

tables_num=`mysql -u$HARBOR_MYSQL_USR -p$HARBOR_MYSQL_PWD -h$HARBOR_MYSQL_HOST -P$HARBOR_MYSQL_PORT -e "show databases"|grep registry|wc -l`
if [ $tables_num -eq 0 ];then
	mysql -u$HARBOR_MYSQL_USR -p$HARBOR_MYSQL_PWD -h$HARBOR_MYSQL_HOST -P$HARBOR_MYSQL_PORT< ./conf.d/db/registry.sql
fi
