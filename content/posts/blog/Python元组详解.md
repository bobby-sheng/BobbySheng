# Python元组详解

2022-07-27 · bobby

## 一、元组和列表的区别

1、元组无法增删改查，只能通过重新赋值修改元素，可以把元组理解为只可读的列表

2、元组占用内存比列表小，python程序缓存机制对于静态资源占用内存较小的会留缓存，新建相同内存大小的元组时可以从缓存中获取，列表就需要从操作系统寻找内存，速度会快很多

3、元组可以在映射（和集合的成员）中当做“键”使用，而列表不行

## 二、元组的基本使用

### 1、tuple函数的使用

```python
# tuple函数的功能与list函数基本上是一样的：以一个序列作为参数并把它转化为元组。如果参数就是元组，那么该函数就会被原样返回：
>>> tuple([1,2,3])
(1, 2, 3)
>>> tuple('abc')
('a', 'b', 'c')
>>> tuple((1,2,3))
(1, 2, 3)
#可以通过转为元组，再转为列表，做一些字符串的处理
```

### 3、索引

```python
# tuple之索引取值
name_tuple = ('nick', 'jason', 'tank', 'sean')
# name_tuple[0] = 'nick handsom'  # 报错

print(name_tuple[0]) #nick
```

### 4、切片

```python
# tuple之切片
name_tuple = ('nick', 'jason', 'tank', 'sean')

print(name_tuple[1:3:2])#jason
```

### 5、长度

```python
# tuple之切片
name_tuple = ('nick', 'jason', 'tank', 'sean')

print len(name_tuple)#4
```

### 6、成员运算

```python
# tuple之成员运算
name_tuple = ('nick', 'jason', 'tank', 'sean')

print('nick' in name_tuple) #True
```

### 7、循环

```python
# tuple之循环
name_tuple = ('nick', 'jason', 'tank', 'sean')

for name in name_tuple:
    print(name)
```

### 8、统计值个数count()

```python
# tuple之count()
name_tuple = ('nick', 'jason', 'tank', 'sean')

print(name_tuple.count('nick'): )#1
```

### 7、返回值的索引位置-index(值)

```python
# tuple之index()
name_tuple = ('nick', 'jason', 'tank', 'sean')

print(name_tuple.index('nick'): )#0
```