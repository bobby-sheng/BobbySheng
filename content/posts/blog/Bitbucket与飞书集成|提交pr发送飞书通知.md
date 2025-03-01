---
title: "Bitbucket与飞书集成|提交pr发送飞书通知"
date: 2025-03-01
lastmod: 2024-05-16
tags:
  - Python
keywords:
  - Python
description: "Bitbucket与飞书集成|提交pr发送飞书通知"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/cf7de6d9cd14daa933b2b.jpg"
---

# 背景
同事合并代码每次都在群里@相关人员，于是就出了这个功能。提高工作效率，不用天天群里找人很麻烦

# 需求分析
仓库提交pr，发送通知并且艾特相关人员

# 方案调研
bitbucket 平台有webhook，我们现在用的飞书也有群消息机器人，提供api发送信息，我只需要在中间做一层服务接受bitbucket 的pr请求，处理好后通过飞书机器人发送到群并艾特人员
暂时无法在飞书文档外展示此内容

# 实现步骤
## 一、前置准备
- Python fastapi 相关知识
- bitbucket 平台管理员，可以设置webhook
- 飞书群
- bitbucket 和 本地Python fastapi 服务网络互通
## 二、执行步骤
1、写一个接口fastapi接口，并且启动服务

2、bitbucket  配置webhook。填写fastapi 服务启动的ip和port和路径
![输入图片说明](https://foruda.gitee.com/images/1740840015837549025/3bbd058c_5617712.png "屏幕截图")

3、fastapi服务用于接收处理bitbucket webhook传递来的消息，先调试处理好
![输入图片说明](https://foruda.gitee.com/images/1740840055301206224/dc195b32_5617712.png "屏幕截图")

4、创建飞书群机器人，获取webhook
![输入图片说明](https://foruda.gitee.com/images/1740840065632358738/2106cdce_5617712.png "屏幕截图")
![输入图片说明](https://foruda.gitee.com/images/1740840079919907165/616dac8f_5617712.png "屏幕截图")
![输入图片说明](https://foruda.gitee.com/images/1740840088299044295/1ff4380b_5617712.png "屏幕截图")

5、处理数据并且放入飞书机器人data中，准备机器人发送请求的接口
![输入图片说明](https://foruda.gitee.com/images/1740840096793296495/72418857_5617712.png "屏幕截图")

6、调用此机器人消息接口

飞书接口消息体的请求方式有更加详细的问题，花点时间就可以搞定。希望和我一样使用卡片消息的话需要借助飞书的消息卡片搭建工具，通过ui 的方式处理好样式后可以把源代码复制下来，填充到data中去。就可以使用美观的消息卡片。
![输入图片说明](https://foruda.gitee.com/images/1740840103912943433/0360427f_5617712.png "屏幕截图")

# 实际效果
点击进入审批按钮可以直接进入到相关的页面，这个链接也是从bitbucket 传递过来的数据处理下来的。至此此服务完成
![输入图片说明](https://foruda.gitee.com/images/1740840111040488099/8f34c4e4_5617712.png "屏幕截图")

