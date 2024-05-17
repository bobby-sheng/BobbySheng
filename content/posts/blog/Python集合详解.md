---
title: "Python集合详解"
date: 2022-07-27
lastmod: 2022-07-27
tags:
  - Python
keywords:
  - Python
description: "用于关系运算的集合体，由于集合内的元素无序且集合元素不可重复，因此集合可以去重，但是去重后的集合会打乱原来元素的顺序"
cover:
    image: "img/python001.png"
---

## 一、集合常用方法

### 1、长度len

```bash
c={"c","1","o","r"}
print len(c) #4
```

### 2、成员运算in和not in

```bash
c={"c","1","o","r"}
print "c" in c  #True
print "b" in c  #False
```

### 3、|并集、union

```bash
#两个集合去重复拼接
c={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}
print c|b
print c.union(b)

#set(['nike', 'bobby', 'tow', 'three', 'four', 'oen', 'hello'])
#set(['nike', 'bobby', 'tow', 'three', 'four', 'oen', 'hello'])
```

### 4、&交集、intersection

```bash
#两个集合之间存在相同的值
c={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}
print c&b
print c.intersection(b)

#set(['nike'])
#set(['nike'])
```

### 5、-差集、difference

```bash
#打印出集合1对比集合2不同的值
c={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}
print c-b
print b.difference(c)

#set(['tow', 'oen', 'bobby'])
#set(['four', 'hello', 'three'])
```

### 6、^对称差集、symmetric_difference

```bash
#去除两个集合之间相同的值，然后拼接为一个集合
c={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}
print c^b
print b.symmetric_difference(c)

#set(['bobby', 'three', 'tow', 'four', 'oen', 'hello'])
#set(['bobby', 'tow', 'three', 'four', 'oen', 'hello'])
```

### 7、两集合是否相同-==

```bash
#判断两个集合是否一样-
c={"oen","tow","nike","bobby"}
a={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}

print c==b #False
print c==a #True
```

### 8、父集：>、>= 、issuperset

```bash
#判断集合1是否为集合2的父集，返回布尔值
c={"oen","tow","nike","bobby"}
a={"oen","tow"}
b={"three","four","nike","hello"}

print c>=a #True
print c>a #True
print b>=a #False
```

### 9、子集：<、<= 、issubset

```bash
#判断集合1是否为集合2的子集，返回布尔值
c={"oen","tow","nike","bobby"}
a={"oen","tow"}
b={"three","four","nike","hello"}
print a<=c #True
print a<c #True
print a<=b #False
```

## 二、集合内置方法

### 1、增加元素-set.add()

```bash
c={"oen","tow","nike","bobby"}
c.add("uu")
print c
#set(['uu', 'bobby', 'nike', 'oen', 'tow'])
```

### 2、增加元组-set.update(set)

```bash
#填入字符串默认转化为set格式，所以重复的字符串只能加入1次
c={"oen","tow","nike","bobby"}
b={"three","four","nike","hello"}
c.update("fff")
print c #set(['bobby', 'nike', 'oen', 'f', 'tow'])
```

### 3、删除元素

```bash
#第一种-set.remove(值)
c={"oen","tow","nike","bobby"}
c.remove("oen")
print c
#set(['bobby', 'nike', 'tow'])

#第二种-set.pop(),默认最后一个
c={"oen","tow","nike","bobby"}
c.pop()
print c
#set(['nike', 'oen', 'tow'])

#第三种-set.clear(),清空所有
c={"oen","tow","nike","bobby"}
c.clear()
print c
#set([])
```

### 4、移除元素-discard()

```bash
#如果x在集合S中，移除该元素；如果x不在集合S中，不报错
c={"oen","tow","nike","bobby","aa"}
b={"three","four","nike","hello","aa"}
c.discard("oen")
print c #set(['aa', 'bobby', 'nike', 'tow'])
```

### 5、并集判断-isdisjoint()

```bash
#如果集合S与T没有相同元素，返回True
c={"oen","tow","nike","bobby","aa"}
b={"three","four","nike","hello","aa"}
a={"1","2"}
c.discard("tow")
print c.isdisjoint(b) #False
print c.isdisjoint(a) #True
```