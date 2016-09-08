### 准备环境
1. docker
2. docker-compose

### 加载镜像
./loadImages.sh

### 更改配置
更改 --SERVICE_IP-- 为本机的 IP
grep '--SERVICE_IP--' . -ril | xargs sed -i 's/--SERVICE_IP--/REALIP/g'

### 更改本机的 docker 配置增加 --insecure-registry REALIP
systemctl daemon-reload ; systemctl restart docker.service

### 运行harbor, registry, mysql, nginx, jobservice
docker-compose up -d

### 登陆 
docker login REALIP     user:admin passwd:Harbor12345
登陆 web 页面 http://IPIPIPIP

#### 注意点
如果用已有数据库则需要导入数据库 registry
mysql -h x.x.x.x -u root -p < ./config/db/registry.sql
并且需要更改 config 目录下项目 mysql 的相关信息
