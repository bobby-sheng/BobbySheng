---
title: "基于cloudflare搭建For Myself免费的图床"
date: 2024-05-19
lastmod: 2024-05-19
tags:
  - Hogo
keywords:
  - Hogo
description: "基于cloudflare搭建For Myself免费的图床"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/fc346c231715fd0205e5c.png"
---

# 背景
当前个人博客使用的图片均是本地文件读取的，经过测试在github page部署出来的网站加载图片非常慢，而且编写博客时使用本地图片的操作也比较繁琐，于是想搞个图床，这样加载速度和编写文章会方便很多
# 调查
经过搜索发现可通过大佬开源的框架，部署到cloudflare pages 可实现个人专属的免费图床
## 开源框架：
地址：
https://github.com/cf-pages/Telegraph-Image

特性：
1. 无限图片储存数量，你可以上传不限数量的图片
2. 无需购买服务器，托管于 Cloudflare 的网络上，当使用量不超过 Cloudflare 的免费额度时，完全免费
3. 无需购买域名，可以使用 Cloudflare Pages 提供的*.pages.dev的免费二级域名，同时也支持绑定自定义域名
4. 支持图片审查 API，可根据需要开启，开启后不良图片将自动屏蔽，不再加载
5. 支持后台图片管理，可以对上传的图片进行在线预览，添加白名单，黑名单等操作
# cloudflare简介
之前没接触过此平台，记录下简介

Cloudflare 的使命是帮助构建更好的互联网。
Cloudflare 是世界最大的网络之一。今天，企业、非营利组织、博客作者和任何有互联网存在的人都因为 Cloudflare 而拥有更快、更安全的网站和应用。
[Cloudflare 是什么？](https://www.cloudflare-cn.com/learning/what-is-cloudflare/?external_link=true)
## 总结：
1. 此产品功能还是牛逼的，有免费的CDN可以使用
2. 可以做很多东西，网络安全、网站部署，CDN等

# Do it
1. fork开源代码到自己的github仓库
![image-2323](https://telegraph-image-f19.pages.dev/file/cfbaf70463bb96bbced4c.png)
2. 注册并登陆Cloudflare,打开pages
![image-2323](https://telegraph-image-f19.pages.dev/file/ec5346b16180f1f62eb7d.png)
3. 选择GitHub关联仓库
![image-2323](https://telegraph-image-f19.pages.dev/file/e7b674e683fd6170a3b4f.png)
4. 下一步再下一步,不需要输入其他,就会进入到创建界面,是不是很简单,哈哈
![image-2323](https://telegraph-image-f19.pages.dev/file/3e3697767851bf0f9cdd7.png)
5. 开始访问,就出现了图片上传到client界面,看起来很nice,这里只是完成了前端上传部分,后面我们还需要管理上传到图片,嘿嘿.继续干
![image-2323](https://telegraph-image-f19.pages.dev/file/27b745d262369238099ce.png)
上传图片完成后会自动生成url
![image-2323](https://telegraph-image-f19.pages.dev/file/6e43ead554bc675c92d97.png)
6. 创建命名空间指定名称img_url
![image-2323](https://telegraph-image-f19.pages.dev/file/395867af19fbc703add10.png)
![image-2323](https://telegraph-image-f19.pages.dev/file/76fc9e3b58d0ba95cbcc7.png)
7. 打开设置页面,找到kv命名空间绑定,并点击开始使用,并且绑定上面步骤add好的命名,保存完成后重新部署
![image-2323](https://telegraph-image-f19.pages.dev/file/7d93d88950819204ed9cf.png)
![image-2323](https://telegraph-image-f19.pages.dev/file/1c7c14563996f236f9b6f.png)

![image-2323](https://telegraph-image-f19.pages.dev/file/9fc1a7c358481f68b4dfe.png)
8. 创建变量,作为后台管理的账户密码
BASIC_USER 用户名
BASIC_PASS 密码
![image-2323](https://telegraph-image-f19.pages.dev/file/a7de5af971556c011bb96.png)
9. 重新部署程序后,在client界面等url中添加/admin 输入账号密码即可等你后台管理,就可以看到上传的图片,可以进行编辑,复制图片路径等操作
![image-2323](https://telegraph-image-f19.pages.dev/file/fe6bd3bdf8fa6a35d56c7.png)
![image-2323](https://telegraph-image-f19.pages.dev/file/f7e7dc5bb93ce75d86027.png)

# 总结
解决了博客加载图片慢以及md格式文件使用图片麻烦等难题
很棒很喜欢



