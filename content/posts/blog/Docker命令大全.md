---
title: "Docker命令大全"
date: 2022-06-27 
lastmod: 2022-06-27 
tags:
  - docker
keywords:
  - docker
description: "docker主要分为镜像、容器。个人理解镜像是一个封装好的仓库，容器就是把这个仓库拿过来，里面的东西原封不动，可以随意操作而不会影响镜像内容，一个镜像可以创建多个容器。比较方便"
cover:
    image: "img/docker_info.jpg"
---
## 一、docker基础命令

**1.启动docker**

```bash
systemctl start docker
```

**2.关闭docker**

```bash
systemctl stop docker
```

**3.重启docker**

```bash
systemctl restart docker
```

**4.docker设置随服务启动而自启动**

```bash
systemctl enable docker
```

**5.查看docker 运行状态**

```bash
systemctl status docker
```

**6.查看docker 版本号信息**

```bash
docker version
docker info
```

**7.docker 帮助命令**

```bash
docker --help
docker pull --help
```

## 二、docker镜像命令

**1.查看自己服务器中docker 镜像列表**

```bash
docker images
```

**2.搜索镜像**

```bash
docker search 镜像名
```

**3.拉取镜像**

```bash
docker pull 镜像名 
docker pull 镜像名:tag
```

**4.运行镜像**

```bash
docker run 镜像名
docker run 镜像名:Tag
docker pull tomcat
docker run tomcat
```

**5.删除镜像** ——当前镜像没有被任何容器使用才可以删除

```bash
#删除一个
docker rmi -f 镜像名/镜像ID

#删除多个 其镜像ID或镜像用用空格隔开即可 
docker rmi -f 镜像名/镜像ID 镜像名/镜像ID 镜像名/镜像ID

#删除全部镜像  -a 意思为显示全部, -q 意思为只显示ID
docker rmi -f $(docker images -aq)
```

**6.强制删除镜像**

```bash
docker image rm 镜像名称/镜像ID
```

**7.保存镜像** 将我们的镜像 保存为tar 压缩文件 这样方便镜像转移和保存 ,然后 可以在任何一台安装了docker的服务器上 加载这个镜像

```bash
docker save 镜像名/镜像ID -o 镜像保存在哪个位置与名字
docker save tomcat -o /myimg.tar
```

**8.加载镜像** 任何装 docker 的地方加载镜像保存文件,使其恢复为一个镜像

```bash
docker load -i 镜像保存文件位置
```

**9.镜像标签** 有的时候呢，我们需要对一个镜像进行分类或者版本迭代操作，比如我们一个微服务已经打为docker镜像，但是想根据环境进行区分为develop环境与alpha环境，这个时候呢，我们就可以使用Tag，来进对镜像做一个标签添加，从而行进区分；版本迭代逻辑也是一样，根据不同的tag进行区分

```bash
app:1.0.0 基础镜像
# 分离为开发环境
app:develop-1.0.0   
# 分离为alpha环境
app:alpha-1.0.0   
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag 源镜像名:TAG 想要生成新的镜像名:新的TAG
# 如果省略TAG 则会为镜像默认打上latest TAG
docker tag aaa bbb
# 上方操作等于 docker tag aaa:latest bbb:test
# 我们根据镜像 quay.io/minio/minio 添加一个新的镜像 名为 aaa 标签Tag设置为1.2.3
docker tag quay.io/minio/minio:1.2.3 aaa:1.2.3
# 我们根据镜像 app-user:1.0.0 添加一个新的镜像 名为 app-user 标签Tag设置为alpha-1.0.0
docker tag app-user:1.0.0 app-user:alpha-1.0.0
```

## 三、docker容器命令

**1.查看正在运行容器列表**

```bash
docker ps
```

**2.查看所有容器 —–包含正在运行 和已停止的**

```bash
docker ps -a
容器怎么来呢 可以通过run 镜像 来构建 自己的容器实例
```

**3.运行一个容器**

```bash
# -it 表示 与容器进行交互式启动 -d 表示可后台运行容器 （守护式运行）  --name 给要运行的容器 起的名字  /bin/bash  交互路径
docker run -it -d --name 要取的别名 镜像名:Tag /bin/bash 

#1. 拉取redis 镜像
docker pull redis:5.0.5
#2.命令启动
docker run -it -d --name redis001 redis:5.0.5 /bin/bash
#3.查看已运行容器
docker ps
# netstat是控制台命令,是一个监控TCP/IP网络的非常有用的工具，它可以显示路由表、实际的网络连接以及每一个网络接口设备的状态信息
netstat -untlp
```

**4.删除容器**

```bash
删除一个容器
docker rm -f 容器名/容器ID
#删除多个容器 空格隔开要删除的容器名或容器ID
docker rm -f 容器名/容器ID 容器名/容器ID 容器名/容器ID
#删除全部容器
docker rm -f $(docker ps -aq)
```

**5.容器端口与服务器端口映射**

```bash
-p 宿主机端口:容器端口

#把redis1容器的6373端口映射为宿主机的8888，在外部访问8888时会指向容器的6373端口

docker run -itd --name redis1 -p 8888:6373 redis:5.0.5 /bin/bash
```

**6.进入容器方式**

```bash
docker exec -it 容器名/容器ID /bin/bash

docker attach 容器名/容器ID
```

**7.从容器内 退出到自己服务器中** 需注意 两个退出命令的区别

```bash
#-----直接退出  未添加 -d(持久化运行容器) 时 执行此参数 容器会被关闭  
exit
12
# 优雅提出 --- 无论是否添加-d 参数 执行此命令容器都不会被关闭
Ctrl + p + q
```

**8.停止容器**

```bash
docker stop 容器ID/容器名
```

**9.重启容器**

```bash
docker restart 容器ID/容器名
```

**10.启动容器**

```bash
docker start 容器ID/容器名
```

**11.kill 容器**

```bash
docker kill 容器ID/容器名
```

**12.容器文件拷贝** —无论容器是否开启 都可以进行拷贝

```bash
#docker cp 容器ID/名称:文件路径  要拷贝到外部的路径   |     要拷贝到外部的路径  容器ID/名称:文件路径
#从容器内 拷出
docker cp 容器ID/名称: 容器内路径  容器外路径
#从外部 拷贝文件到容器内
docker  cp 容器外路径 容器ID/名称: 容器内路径
```

**13.查看容器日志**

```bash
docker logs -f --tail=要查看末尾多少行 默认all 容器ID
```

**14.设置容器开机自启动**

```bash
--restart=always

docker run -itd --name redis002 -p 8888:6379 --restart=always redis:5.0.5 /bin/bash
```

**15.容器挂载文件**（在启动时需要设置好，可以挂载多个文件）

```bash
-v 宿主机文件存储位置:容器内文件位置 -v 宿主机文件存储位置:容器内文件位置 -v 宿主机文件存储位置:容器内文件位置

# 运行一个docker redis 容器 进行 端口映射 两个数据卷挂载 设置开机自启动
docker run -d -p 6379:6379 --name redis505 --restart=always  -v /var/lib/redis/data/:/data -v /var/lib/redis/conf/:/usr/local/etc/redis/redis.conf  redis:5.0.5 --requirepass "password"
```

**16.修改容器启动配置**

```bash
docker  update --restart=always 容器Id 或者 容器名

或

docker container update --restart=always 容器Id 或者 容器名
```

**17.更换容器名**

```bash
docker rename 容器ID/容器名 新容器名
```

**18.修改容器后提交为镜像**

```bash
docker commit -m="提交信息" -a="作者信息" 容器名/容器ID 提交后的镜像名:Tag
```

到这里docker常用命令结束了，这些足够工作中使用了。