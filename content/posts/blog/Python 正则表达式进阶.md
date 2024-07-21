---
title: "Python 正则表达式"
date: 2024-07-21
lastmod: 2024-07-21
tags:
  - Python
keywords:
  - Python
description: "Python 正则表达式"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/b58433d3a3f238c52fcd4.jpg"
---
# 背景
从业这么多年， 对正则并没有太多的研究，需要的时候上网搜一搜，能拿到结果就行。由于不太懂，在日常代码处理数据中使用的还是数据结构较多，所以正则不精通没有太影响到我的工作。刚好公司有一部分功能业务是需要使用正则去匹配的，研究了下发现正则还是很强大的。正好借这个劲头把python的正则都学了，这里做一个学习笔记。

# 元字符介绍
## 元字符的完整列表
只需要记住以下元字符，对比操作即可。
. ^ $ * + ? { } [ ] \ | ( )
![image-2328](https://telegraph-image-f19.pages.dev/file/1904ab548d77750557020.jpg)
# Python re模块使用
## re.compile函数
编译正则表达语句，因为正则表达语句有一些特殊字符，在python很难以识别，或者识别错误，这个方法就是把输入的字符串转换为正则的模式给到下面寻找函数的使用
```python
>>>import re
>>> pattern = re.compile(r'\d+')                    # 用于匹配至少一个数字
>>> m = pattern.match('one12twothree34four')        # 查找头部，没有匹配
>>> print( m )
```
## re.match函数
从开头的位置查找，如果开头就没匹配到就返回None了。那么下面的这个例子返回的是个None，因为从开头的位置没找到数字。可以通过后面的位置参数定位哪里算是开头
```python
>>>import re
>>> pattern = re.compile(r'\d+')                    # 用于匹配至少一个数字
>>> m = pattern.match('one12twothree34four')        # 查找头部，没有匹配
>>> print( m )
None
>>> m = pattern.match('one12twothree34four', 2, 10) # 从'e'的位置开始匹配，没有匹配
>>> print( m )
None
>>> m = pattern.match('one12twothree34four', 3, 10) # 从'1'的位置开始匹配，正好匹配
>>> print( m ) 
```
## re.search函数
匹配整个字符串，直到找到一个匹配。如果没找到就是None
```python
>>>import re
 
>>>line = "Cats are smarter than dogs"

>>>matchObj = re.search( r'dogs', line, re.M|re.I)
>>>if matchObj:
>>>   print ("search --> matchObj.group() : ", matchObj.group())
>>>else:
>>>   print ("No match!!")

>>> search --> matchObj.group() :  dogs
```
## re.findall函数
匹配整个字符串，找到所有匹配，返回一个列表，也可以通过字符串切片位置限制范围
```python
>>>import re
 
>>>result1 = re.findall(r'\d+','runoob 123 google 456')
>>> ['123', '456']
>>>pattern = re.compile(r'\d+')   # 查找数字
>>>result2 = pattern.findall('runoob 123 google 456')
>>> ['123', '456']
>>>result3 = pattern.findall('run88oob123google456')
>>> ['88','123', '456']
>>>result3 = pattern.findall('run88oob123google456'，0, 10)
>>> ['88','123']
```
## re.split函数
通过正则表达式的匹配拆分 字符串。 如果在正则中使用捕获括号，则它们的内容也将作为结果列表的一部分返回。 如果 maxsplit 非零，则最多执行 maxsplit 次拆分。
```python
>>> p = re.compile(r'\W+')
>>> p.split('This is a test, short and sweet, of split().')
['This', 'is', 'a', 'test', 'short', 'and', 'sweet', 'of', 'split', '']
>>> p.split('This is a test, short and sweet, of split().', 3)
['This', 'is', 'a', 'test, short and sweet, of split().']

>>> #也可以切割逗号，或者切割空格
>>> p = re.compile(r'\s')
>>> p = re.compile(r',')
```
还可以通过把正则分组形式生成被切割的数据
```python
>>> p = re.compile(r'\W+')
>>> p2 = re.compile(r'(\W+)')
>>> p.split('This... is a test.')
['This', 'is', 'a', 'test', '']
>>> p2.split('This... is a test.')
['This', '... ', 'is', ' ', 'a', ' ', 'test', '.', '']

>>> # 模块使用时参数添加到后面参数
>>> re.split(r'[\W]+', 'Words, words, words.')
['Words', 'words', 'words', '']
>>> re.split(r'([\W]+)', 'Words, words, words.')
['Words', ', ', 'words', ', ', 'words', '.', '']
>>> re.split(r'[\W]+', 'Words, words, words.', 1)
['Words', 'words, words.']
```
## re.sub函数
搜索和替换函数，把正则找到的数据进行替换，也可以传入函数去处理需要替换的数据
```python
>>> p = re.compile('(blue|white|red)')
>>> p.sub('colour', 'blue socks and red shoes')
'colour socks and colour shoes'
>>> p.sub('colour', 'blue socks and red shoes', count=1)
'colour socks and red shoes'
```

subn()函数也是一样的左右，但是他会返回替换了几个数据的总结
```python
>>> p = re.compile('(blue|white|red)')
>>> p.subn('colour', 'blue socks and red shoes')
('colour socks and colour shoes', 2)
>>> p.subn('colour', 'no colours at all')
('no colours at all', 0)
```
# 参考文件
[正则表达式指南](https://docs.python.org/zh-cn/3.11/howto/regex.html#introduction)

[Python3 正则表达式](https://www.runoob.com/python3/python3-reg-expressions.html)

总结
正则还是挺强大和有意思的，如果能用好是工作的一大利器。目前看起来其实并不难，不知道为啥之前不愿意去学这个，可能看到元字符组合比较复杂难以理解。后面就得多去应用，用多了自然就熟了。公司大佬安利的正则在线编译网站，很强大，我也是通过这个网站直观的看到数据的变化才学起来轻松的。
https://regex101.com/
