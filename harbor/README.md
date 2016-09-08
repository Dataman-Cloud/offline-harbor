### 准备环境
1. docker
2. docker-compose

### 更改配置
按照实际情况更改 `config.cfg` 配置文件
### 更改其它主机的 docker 配置增加 --insecure-registry
        # vi /lib/systemd/system/docker.service
        # systemctl daemon-reload ; systemctl restart docker.service
### 运行harbor, registry, mysql, nginx, jobservice
运行 `run.sh` 启动项目
### 登陆 
- docker
    
        docker login harbor_ip     
        user:admin passwd:Harbor12345
登陆 web 页面
    
        http://harbor_ip

## 注意
如果用已有数据库则需要导入数据库 registry

    mysql -h x.x.x.x -u root -p < ./config/db/registry.sql