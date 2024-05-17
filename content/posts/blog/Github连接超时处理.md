---
title: "Github连接超时处理"
date: 2022-06-16
lastmod: 2022-06-16
tags:
  - Git
keywords:
  - Git
description: "flask-SQLAlchemy对sqlite数据库的连接与增删改查"
cover:
    image: "img/github001.png"
---

### 1、通过以下地址获取速度较快的ip作为映射地址(需要在本地可以ping通的)

```python
https://ping.chinaz.com/github.com
```

### 2、Windows系统配置

a.打开host文件，路径一般是下面这个

```python
C:\Windows\System32\drivers\etc\
```

b.在host文件中加找到的ip做github.com的映射

```python
52.192.72.89	github.com
```

c.Windows系统需要重启DNS解析配置才会生效

```python
ipconfig /flushdns
```

### 3、Linux系统配置

a. vim /etc/hosts增加获取到的代理ip

```python
52.192.72.89	github.com
```

总结：获取到可ping通的代理地址后配置到hosts系统文件中，打开网页访问域名的时候会指向你配置的那个ip。Windows和Linux系统配置差不多，Windows需要重启下DNS解析。