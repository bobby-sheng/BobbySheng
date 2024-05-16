---
title: "wordpress | 配置免费 ssl 证书和 https 强制跳转" 
date: 2021-07-01
lastmod: 2024-01-28
tags:
  - wordpress
  - 博客搭建
keywords:
  - wordpress
  - 阿里云
  - ssl
  - https
  - apache
  - 伪静态
  - Rewrite
description: "介绍如何为阿里轻量应用服务器 (wordpress 应用) 配置 ssl 证书，开启 https 访问且实现https 强制跳转" 
cover:
    image: "https://image.Bobby.cn/blog/wordpress.jpg" 
---

# 0 前言

本文参考以下链接:

- [在 Apache 服务器上安装 SSL 证书](https://help.aliyun.com/zh/ssl-certificate/user-guide/install-ssl-certificates-on-apache-servers)
- [WordPress 强制跳转 https 教程](https://blog.csdn.net/weixin_39037804/article/details/102801202)

# 1 配置 ssl 证书

1、登录阿里云，选择产品中的 ssl 证书

![image-20210722101058428](https://image.Bobby.cn/blog/image-20210722101058428.png)

![image-20210722101227085](https://image.Bobby.cn/blog/image-20210722101823832.png)

![image-20210722101412400](https://image.Bobby.cn/blog/image-20210722101412400.png)

![image-20210722101823832](https://image.Bobby.cn/blog/image-20210722102007056.png)

![image-20210722101908523](https://image.Bobby.cn/blog/image-20210722101908523.png)

![image-20210722102007056](https://image.Bobby.cn/blog/image-20210722102536194.png)

如果域名是阿里的他会自动创建 dns 解析，如果是其他厂商需要按照图片配置，等待几分钟进行验证

![image-20210722102536194](https://image.Bobby.cn/blog/image-20210722103005297.png)

![image-20210722102208389](https://image.Bobby.cn/blog/image-20210722101227085.png)

点击审核，等待签发

![image-20210722103005297](https://image.Bobby.cn/blog/image-20210722102208389.png)

签发后根据需求下载所需证书

![image-20210722104732852](https://image.Bobby.cn/blog/image-20210722104550144.png)

我的 wordpress 是直接买的阿里轻量应用服务器，打开轻量应用服务器的控制台配置域名

![image-20210722104550144](https://image.Bobby.cn/blog/image-20210722104732852.png)

选择刚申请好的 ssl 证书

![image-20210722104631428](https://image.Bobby.cn/blog/image-20210722104631428.png)

在 wordpress 后台修改地址

![image-20210722104952260](https://image.Bobby.cn/blog/image-20210722104952260.png)

大功告成

# 2 配置 https 强制跳转

一般站点需要在 httpd.conf 中的 `<VirtualHost *:80> </VirtualHost>` 中配置重定向

wordpress 不同，需要在伪静态文件（.htaccess）中配置重定向，无需在 httpd.conf 中配置

## 2.1 修改伪静态文件（.htaccess）

伪静态文件一般在网页根目录，是一个隐藏文件

![image-20210730101401874](https://image.Bobby.cn/blog/image-20210730101401874.png)

在 `#END Wordpress` 前添加如下重定向代码，**记得把域名修改成自己的**

```plaintext
RewriteEngine On
RewriteCond %{HTTPS} !on
RewriteRule ^(.*)$ https://Bobby.cn/%{REQUEST_URI} [L,R=301]
```

图中两段重定向代码略有不同

- 第一段代码重定向触发器：**当访问的端口不是 443 时进行重定向**重定向规则：**重定向到：https://{原域名}/{原 url 资源}**
- 第二段代码重定向触发器：**当访问的协议不是 TLS/SLL（https）时进行重定向**重定向规则：**重定向到：<https://Bobby.cn/>{原 url 资源}**
- 第一段代码使用端口判断，第二段代码通过访问方式判断，建议使用访问方式判断，这样服务改了端口也可以正常跳转
- 第一段代码重定向的原先的域名，第二段代码可以把 ip 地址重定向到指定域名

![image-20210730152548351](https://image.Bobby.cn/blog/image-20210730152548351.png)

## 2.2 测试

```bash
curl -I http://Bobby.cn
```

![image-20210730153518000](https://image.Bobby.cn/blog/image-20210730153518000.png)

使用 http 访问站点的 80 端口成功通过 301 跳转到了 https

以上
