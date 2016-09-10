#!/bin/bash
. ../config.cfg

usage="$0 <user_name> <user_pass> <db_name> [is_create_db: true|false]"
[ -z "$1" ] && echo "$usage" && exit 1
[ -z "$2" ] && echo "$usage" && exit 1
[ -z "$3" ] && echo "$usage" && exit 1

mysql_port="3306"
rpasswd=$SRY_MYSQL_ROOT_PASSWORD

user_name="$1"
passwd="$2"
db_name="$3"
is_create_db="$4"

ip=$HARBOR_MYSQL_HOST

sql=""
if [ "$is_create_db" ];then
	sql="CREATE DATABASE IF NOT EXISTS $db_name;"
        mysql -uroot -h$ip -P$mysql_port -p$rpasswd -e "$sql" || exit 1
fi

sql="
	GRANT ALL PRIVILEGES ON $db_name.* TO '$user_name'@'%' IDENTIFIED BY '$passwd';
	flush privileges;
"

#echo "mysql -uroot -h$ip -P$mysql_port -p$rpasswd -e '$sql'"
mysql -uroot -h$ip -P$mysql_port -p$rpasswd -e "$sql" || exit 1
#echo "mysql ip: $ip database: $db_name user: $user_name  passwd : $passwd  -- 请妥善保管"

