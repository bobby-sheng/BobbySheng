---
title: "Zeebe工作流引擎执行py脚本"
date: 2024-08-17
lastmod: 2024-08-17
tags:
  - Python
keywords:
  - Python
description: "Zeebe工作流引擎执行py脚本"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/b58433d3a3f238c52fcd4.jpg"
---
# 背景
项目上有个需求主要做类似于coze工作流编排的工作，一套低代码业务功能。需要使用到“脚本”功能，需要支持自定义python分离脚本，并且执行返回数据。

# 需求分析
需要实现的效果大概如下，在流程中添加“python代码脚本”，保存此工作流后，可以在流程中引用此脚本并执行返回结果。
![image-23144](https://telegraph-image-f19.pages.dev/file/3147614ad1e2cbec5858b.jpg)

# 方案调研
项目主要是java语言开发，那么如何去执行python脚本呢，这里需要使用工作流引擎zeebe。关于zeebe的可以去百度了解下，这是一个微服务系统之间业务衔接更加完美的工具，主要使用grpc请求调用。

# 方案实施
python启动一个服务监听worker，从zeebe中获取入参、数据库中获取分离的python脚本字符串。触发执行完成后返回给到zeebe参数，作为下一个任务使用。
## 逻辑流程图
![图片](https://telegraph-image-f19.pages.dev/file/7769241359a6ecfeeeb5e.png)
## 实现代码
获取数据库数据函数
![图片](https://telegraph-image-f19.pages.dev/file/1da41dd92ab949135e46a.jpg)
执行脚本函数
![图片](https://telegraph-image-f19.pages.dev/file/d92f92a7d2a3435e61202.jpg)
zeebe监听worker
![图片](https://telegraph-image-f19.pages.dev/file/5147957a9aa0b603fd3eb.jpg)
# 完成演示
数据库执行脚本demo
![图片](https://telegraph-image-f19.pages.dev/file/4851d10c0041145446bbe.jpg)
执行返回结果
![图片](https://telegraph-image-f19.pages.dev/file/476a9ee0c3f21639d65fb.jpg)
zeebe工作流执行情况
![图片](https://telegraph-image-f19.pages.dev/file/57750d7d1bc7103dab7d1.jpg)
