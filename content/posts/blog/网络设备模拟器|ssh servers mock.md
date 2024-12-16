---
title: "ssh服务模拟器|simunet"
date: 2024-12-01
lastmod: 2024-12-01
tags:
  - Python
keywords:
  - Python
description: "ssh服务模拟器|simunet"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/b58433d3a3f238c52fcd4.jpg"
---
# 个人源码地址
```python
https://github.com/bobby-sheng/SimuNet
```

# 背景
当前研发与维护过程中必不可少的要去接触网络设备，由于企业级网络设备种类多，我们目前主要使用的还是一些虚拟的网络设备搭建如Pnet、Enev等，这些资源也不完全包括客户那边使用的设备资源，并且使用的都是非正式版，经常需要重新搭建，搭建过程涉及到配网、路由等一系列流程，繁琐且花费时间，在测试这边经常是碰到为了测试一个命令错误校验、策略解析小问题而花费大量的时间去建造资源，时间都花费在了搭建设备以及创建资源上，不仅是工作效率无法提高，重复的工作对执行人也不友好。为此，需要一个可以模拟各个厂商型号、可配置的网络设备mock工具。

# 效果展示
Mock Cisco ASA 防火墙做模式切换和退出模式动作 mockarray

Array AG 设备做命令流水线下发错误命令捕获测试

在配置文件中定义好Array设备错误的返回字符 mockssh

使用netdevices接口ssh上mock server 服务，并且断言错误 image

# 需求分析
V1
可以正常的ssh连接
通过配置文件控制同时开启多个设备的模拟和设备的模式切换、命令下发以及返回、退出模式
V2
提供web ui 操作
提供接口
可通过对配置文件的增删查热更新服务，实时变化，灵活使用


# 配置文件解释
1. port：ssh 服务使用的端口
2. prompt： 初始进入的prompt
3. cmd_resp_map： 自定义执行命令map，key 为执行命令，data["response'] 为输入命令的自定义返回，data["mode'] 为执行此命令的prompt层级
4. switch_mode_map ： 自定义模式切换，防火墙中有login、enable模式，需要切换
5. exit_map： 退出模式。有的防火墙exit是退出，Huawei防火墙则是q、quit 退出上一层，exit断开连接，由此区分
6. mode_level： 退出模式下，防火墙模型的退出等级。是一层一层的退出的，而不是一下到最外层。所以使用登记区分