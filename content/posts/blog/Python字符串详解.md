# Python字符串详解

2022-07-25 · bobby

## 一、字符串常用方法

### 1、索引-str[0]

```python
#从0开始

msg="bobby"

#b
print msg[0]
```

### 2、切片-str[:::]

```python
# 索引切片
msg = 'hello nick'
#      0123456789  # 索引序号

print(f'切片3-最后: {msg[3:]}')
print(f'切片3-8: {msg[3:8]}')
print(f'切片3-8，步长为2: {msg[3:8:2]}')
print(f'切片3-最后，步长为2: {msg[3::2]}')

# 了解，步长为正从左到右；步长为负从右到左
print('\n**了解知识点**')
print(f'切片所有: {msg[:]}')
print(f'反转所有: {msg[::-1]}')
print(f'切片-5--2: {msg[-5:-2:1]}')
print(f'切片-2--5: {msg[-2:-5:-1]}')
```

### 3、长度-len(str)

```python
msg="bobby"

#5
print len(msg)
```

### 4、成员运算in和not in

```python
msg="bobby"

#True
print "b" in msg
#False
print "k" in msg
```

### 5、移除前后空白或字符-str.strip(“值”)

```python
#去除字符串开头和结尾处指定的字符(默认为空格或换行符)或字符序列，不会去除字符串中间对应的字符。
msg=" bobby "

#bobby
print msg.strip()

#bobby
msg="*#$bobby+"
print msg.strip("*#$+")
```

### 6、切割左到右，与右到左切割-str.split(“值”)和str.rsplit(“值”)

```python
#方法通过指定分隔符对字符串进行分割并返回一个列表，默认分隔符为空字符，包括空格，换行（\n）,制表符（\t）等
msg = " bobby jkkjjkkj\nllll\t222"

# ['bobby', 'jkkjjkkj', 'llll',‘222’]
print msg.split()

msg = " bobby:jkkjjkkj:llll"

# ['bobby', 'jkkjjkkj', 'llll']
print msg.split(":")

#左右切割用法一致，在不控制切割第几个字符的情况下返回值都是一样的，控制切割后结果才会不一样
msg = " bobby:jkkjjkkj:llll"

# [' bobby', 'jkkjjkkj:llll']
# [' bobby:jkkjjkkj', 'llll']

print msg.split(":",1)
print msg.rsplit(":",1)
```

### 7、循环-for

```python
#for 循环取值
msg = " bobby jkkjjkkj\nllll\t222"
for i in msg:
    print i 
```

## 二、字符串需要掌握内置方法

### 1、去除字符串左右两边空格或指定字符-str.lstrip(“值”)和str.rstrip(“值”)

```python
#lstrip()用于去除字符串左边的空格或指定字符
#rstrip()用于去除字符串右边的空格或指定字符。
#lstrip和rstrip去除字符串原理与strip相同，只不过lstrip只从左侧进行匹配去除，rstrip只从右侧进行匹配去除

msg = "***bobby&&&"
#bobby&&&
#***bobby
print msg.lstrip("*")
print msg.rstrip("&&")
```

### 2、字符串转换大小写–str.upper()和str.lower()

```python
#lower()小写，upper()大写

msg = "***bobby&&&"
#***bobby&&&
#***BOBBY&&&
print msg.lower()
print msg.upper()
```

### 3、对比字符串开头结尾值-startswith(“值”)和endswith(“值”)

```python
msg = "bobbysheng"
#True
#True
print msg.startswith("bobby")
print msg.endswith("sheng")
```

### 4、连接列表中的字符串-" “.join(list)

```python
#把列表值全部拆出来，填充上指定的值。与split切割方方法完全相反

#join将 容器对象 拆分并以指定的字符将列表内的元素(element)连接起来，返回字符串（注：容器对象内的元素须为字符类型）
li = ['my','name','is','bob']
s = ['my', 'name', 'is', 'bob']
# my name is bob
# my_name_is_bob
print ' '.join(li)
print '_'.join(li)
#可以通过split方法把join填充的值全部复原为一个列表
li_join="my_name_is_bob"

# ['my', 'name', 'is', 'bob']
print li_join.split("_")
```

### 5、替换字符串-str.replace(old, new[, max])

```python
#把字符串中的 old（旧字符串） 替换成 new(新字符串)，如果指定第三个参数max，则替换不超过 max 次。
str = "this is string example....wow!!! this is really string"

#thwas was string example....wow!!! thwas was really string
#thwas was string example....wow!!! thwas is really string

print str.replace("is", "was")
print str.replace("is", "was", 3)
```

### 6、检测字符串是否只由数字组成-str.isdigit()

```python
#如果字符串包含的是数字类型则返回 True 否则返回 False。
str = "111"
str_false = "111.2"
#True
print str.isdigit()
#False
print str_false.isdigit()
```

### 7、字符串find()、rfind()、index()、rindex()、count()

```python
# find()、rfind()、index()、rindex()、count()
msg = 'my name is tank, tank shi sb, hha'

#11
#-1
#17
#11
#17

#2
print msg.find('tank')  # 找不到返回-1
print msg.find('tank',0,3) # 找不到返回-1
print msg.rfind('tank') # 找不到返回-1
print msg.index('tank') # 找不到报错
print msg.rindex('tank') # 找不到报错

print msg.count('tank')
```

### 8、字符串添加内容center()、ljust()、rjust()、zfill()

```python
center,ljust,rjust,zfillcenter：在center内容中间添加内容

print('egon'.center(50,'*'))

***********************egon***********************
ljust：在ljust内容左边添加内容

print('egon'.ljust(50,'*'))

egon**********************************************
rjust：在ljust内容右边添加内容

print('egon'.rjust(50,'*'))

**********************************************egon
zfill：在zfill内容中加到指定个数

print('egon'.zfill(10))

000000egon
```

### 9、字符串设置制表符代表的空格数str.expandtabs()

```python
#expandtabs()方法返回一个字符串的副本，其中tab字符。使用空格扩展’\t‘，可选地使用给定的制表符大小 - tabize(默认值为8)。
expandtabs

设置制表符代表的空格数

msg='hello\tworld'
print(msg.expandtabs(2)) # 设置制表符代表的空格数为2

hello world
```

### 10、字符串captalize()、swapcase()、title()

```python
captalize：一段字符串的首个字母大写，其余小写

print("hello world egon".capitalize())

Hello world egon
swapcase：一段字符串的首个字母小写，其余大写

print("Hello WorLd EGon".swapcase())

hELLO wORlD egON
title：每个单词的首字母大写，其余小写

print("hello world egon".title())

Hello World Egon
```

### 11、字符串captalize()、swapcase()、title()

```python
captalize：一段字符串的首个字母大写，其余小写

print("hello world egon".capitalize())

Hello world egon
swapcase：一段字符串的首个字母小写，其余大写

print("Hello WorLd EGon".swapcase())

hELLO wORlD egON
title：每个单词的首字母大写，其余小写

print("hello world egon".title())

Hello World Egon
```

### 12、is系列，判断字符串是否属于此格式

```python
1、.isdigit()：判断是否全部都是纯数字类型

print('123'.isdigit())

True
2、.islower()：判断是否全部都是小写字母

print('abc'.islower())

True
3、.isupper()：判断是否全部都是大写字母

print('ABC'.isupper())

True
4、.istitle()：判断是否是单词首个字母大写

print('Hello World'.istitle())

True/5、.isalnum()：判断是否由数字或字母组成

print('123123aadsf'.isalnum()) # 字符串由字母或数字组成结果为True

True
6、.isalpha()：判断是否全部由字母构成

print('ad'.isalpha()) # 字符串由由字母组成结果为True

True
7、.isspace()：判断是否全部由空格构成

print('     '.isspace()) # 字符串由空格组成结果为True

True
8、.isidentifier()：判断是否可以定义为变量名

print('print'.isidentifier())
print('age_of_egon'.isidentifier())
print('1age_of_egon'.isidentifier())

True
True
False   # 变量名不能以数字开头
```

### 13、数字系列的识别

```python
先定义表示同一个数字的4个不同方法：

num1=b'4' #bytes
num2=u'4' #unicode,python3中无需加u就是unicode
num3='四' #中文数字
num4='Ⅳ' #罗马数字
isdigit只能识别：num1、num2

print(num1.isdigit()) # True
print(num2.isdigit()) # True
print(num3.isdigit()) # False
print(num4.isdigit()) # False

True
True
False
False
isnumberic可以识别：num2、num3、num4

print(num2.isnumeric()) # True
print(num3.isnumeric()) # True
print(num4.isnumeric()) # True

True
True
True
isdecimal只能识别：num2

print(num2.isdecimal()) # True
print(num3.isdecimal()) # False
print(num4.isdecimal()) # False

True
False
False
```