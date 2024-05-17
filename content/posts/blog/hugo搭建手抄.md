---
title: "Hugo搭建手抄"
date: 2022-06-16
lastmod: 2022-06-16
tags:
  - Hogo
keywords:
  - Hogo
description: "Hugo搭建手抄"
cover:
    image: "img/hugo001.png"
---
# Hugo搭建手抄

2022-06-07 · bobby

### md文件开端

```bash
#title: "{{ replace .Name "-" " " | title }}" 
#date: {{ .Date }} 
#lastmod: {{ .Date }} 
#author: ["Sulv"] 
#categories:  
#- 分类1 
#- 分类2 
tags:
- 标签1
- 标签2
description: ""
weight: # 输入1可以顶置文章，用来给文章展示排序，不填就默认按时间排序
slug: ""
draft: false # 是否为草稿
comments: true
showToc: true # 显示目录
TocOpen: true # 自动展开目录
hidemeta: false # 是否隐藏文章的元信息，如发布日期、作者等
disableShare: true # 底部不显示分享栏
showbreadcrumbs: true #顶部显示当前路径
cover:
    image: ""
    caption: ""
    alt: ""
    relative: false
#---
```

### hugo操作命令

```bash
hugo -F --cleanDestinationDir 清除后生成public文件，可能会出现漏上传
hugo --buildDrafts   全部生成public

git init
git add .
git commit -m 'create blog'
git remote add origin https://github.com/bobby-sheng/bobby-sheng.github.io.git
git push -u origin master

##如果push失败，比如time out...可尝试下面的命令
git config --global http.sslVerify "false"
git config --global --unset http.proxy
git config --global --unset https.proxy

#(2)之后再修改、更新博客
git add .
git commit -m 'add blogs'
git push -u origin master
bobby-sheng
```