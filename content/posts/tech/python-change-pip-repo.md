---
title: "python | 修改 pip 源" 
date: 2021-12-01
lastmod: 2024-01-28
tags:
  - python
keywords:
  - python
  - pip
description: "" 
cover:
    image: "https://source.unsplash.com/random/400x200?code" 
---

## 1 清单

|                  | 地址                                     |
| ---------------- | ---------------------------------------- |
| 中国科学技术大学 | <https://pypi.mirrors.ustc.edu.cn/simple>  |
| 清华             | <https://pypi.tuna.tsinghua.edu.cn/simple> |
| 豆瓣             | <http://pypi.douban.com/simple>            |
| 华中理工大学     | <http://pypi.hustunique.com/simple>        |
| 山东理工大学     | <http://pypi.sdutlinux.org/simple>         |
| 阿里云           | <https://mirrors.aliyun.com/pypi/simple/>  |

# 2 linux 环境

```bash
mkdir ~/.pip
cat > ~/.pip/pip.conf << EOF 
[global]
trusted-host=mirrors.aliyun.com
index-url=https://mirrors.aliyun.com/pypi/simple/
EOF
```

# 3 windows 环境

打开 cmd 使用 dos 命令 set 找到 userprofile 路径，在该路径下创建 pip 文件夹，在 pip 文件夹下创建 pip.ini


pip.ini 具体配置

```ini
[global]
timeout = 6000
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
```

以上
