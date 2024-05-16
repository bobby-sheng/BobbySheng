# Python字典详解

2022-07-26 · bobby

## 一、字典常用方法

字典是Python中重要的数据类型，字典是由"键-值"对组成的集合，“键-值"对之间用逗号隔开，包含在一对花括号中。字典中的"值"通过"键"来引用。

### 1、定义

```python
#第一种
bobby = {1: 'a', 0: 'b'}
print bobby
#{1: 'a', 0: 'b'}
#第二种
bobby = dict{1 = "a",0 = "b"}
print bobby
#{1: 'a', 0: 'b'}
```

### 2、2种获取字典的value方法

#### 2.1、dict[key]

通过key值获取相应的value值

```python
bobby = {1: 'a', 0: 'b'}

print bobby[1] #a
```

#### 2.1、dict.get(key[,default_value])

参数key表示字典的键值，参数`default_value`可以作为get()的返回值，默认值为None。如果指定`default_value`参数值，表示如果参数key键值在字典key列表中，则返回对应的value值，如果不在，则返回预先设定的`default_value`的值

```python
# default_value参数可以作为未找到value的返回值，默认返回空
bobby = {1: 'a', 0: 'b'}
#有值情况返回值
print bobby.get(1, "ppp") #a

#无值情况返回自定义值
print bobby.get(4, "ppp") #ppp

#无自定义值且找不到值的情况默认返回空
print bobby.get(4) #None
```

### 3、2种添加字典元素方法

#### 3.1、dict[key] = value

如果键值key不在字典dict的key列表中，字典dict添加（key：value）的记录。如果已经在key列表中，则修改键值key对应的value值

```python
bobby = {1: 'a', 0: 'b'}
bobby[3] = "c"
print bobby
#{0: 'b', 1: 'a', 3: 'c'}

#如果已经在key列表中，则修改键值key对应的value值。

bobby[1] = "c"
print bobby
#{0: 'b', 1: 'c'}
```

#### 3.2、dict.setdefault(key[,default_value])

如果索引key在字典key列表中，则返回对应的value值，如果不在key列表中，则添加新索引key和value在字典中，并反馈`default_valu`e值，默认值 为None

```python
#当key存在时，会返回存在的value，并且不修改
bobby = {1: 'a', 0: 'b'}
print bobby.setdefault(1) #a
print bobby #{1: 'a', 0: 'b'}

#当key不存在时，则添加新索引key和value在字典中，并反馈
bobby = {1: 'a', 0: 'b'}
print bobby.setdefault(4，"c") #c
print bobby #{1: 'a', 0: 'b',4:'c'}

#当key不存在时，default_value为空，默认填入null
bobby = {1: 'a', 0: 'b'}
print bobby.setdefault(4) #null
print bobby #{1: 'a', 0: 'b',4:'null'}
```

### 4、获取字典所有keys、Values或者key-valu键值对

```python
#获取字典的所有"键"-"值"元素。通过调用字典的items()方法实现，返回的是(key,value)元组组成的列表
#python2中取出的是列表（鸡蛋）；python3中取出的是元组（鸡）
bobby = {1: 'a', 0: 'b'}
print bobby.items() #[(0, 'b'), (1, 'a')]

#获取所有key,返回列表
bobby = {1: 'a', 0: 'b'}
print bobby.key() #[0, 1]

#获取所有Values,返回列表
bobby = {1: 'a', 0: 'b'}
print bobby.Values() #['b', 'a']
```

### 5、循环

```python
# dic之循环
# dic是无序的，但是python3采用了底层优化算法，所以看起来是有序的，但是python2中的字典是无序
bobby = {1: 'a', 0: 'b'}
for k, v in bobby.items(): 
    print(k, v) #(0, 'b') (1, 'a')
    
 # items可以换成keys()、values()
```

### 6、3种删除字典内容方法

#### 6.1 del dict[key]

```python
#调用py内置方法del
bobby = {1: 'a', 0: 'b'}
del bobby[1]
print bobby #{0: 'b'}
```

#### 6.2 dict.pop(key[,default_value])

pop()函数必须指定参数索引key才能删除对应的值。如果索引key在字典key列表中，则返回索引key对应的value值。如果不存在，则返回预先设置的`default_value`值，如果未设置，会爬出KeyError异常信息

```python
#索引key在字典key列表中，则返回索引key对应的value值
bobby = {1: 'a', 0: 'b'}

print bobby.pop(1) #a
print bobby #{0: 'b'}

#索引key不在字典key列表中，未设置返回值，会直接报错
bobby = {1: 'a', 0: 'b'}

print bobby.pop(3) #KeyError: 3


#索引key在字典key列表中，设置返回值，会返回设置值或者提示
bobby = {1: 'a', 0: 'b'}

print bobby.pop(3,"null") #null
print bobby {0: 'b', 1: 'a'}
```

#### 6.3 dict.clear()

```python
#调用py内置方法del
bobby = {1: 'a', 0: 'b'}
bobby.clear()
print bobby #{}
```

### 7、多个key设值-fromkeys([key,],values)

```python
# dic之fromkeys()
dic = dict.fromkeys(['name', 'age', 'sex'], None)
print dic
#{'name': None, 'age': None, 'sex': None}
```

### 8、两字典合并-1.update(2)

```python
# dic之update()
dic1 = {'a': 1, 'b': 2}
dic2 = {'c': 3}
dic1.update(dic2)

print(dic1)
#dic1: {'a': 1, 'b': 2, 'c': 3}
```

### 9、字典排序-sorted()

```python
dict = {'2':"Python",'1':"Java",'3':"C++"}

sorted(dict.items(),key=lambda d:d[0])
#[('1', 'Java'), ('2', 'Python'), ('3', 'C++')]

sorted(dict.items(),key=lambda d:d[1])
#[('3', 'C++'), ('1', 'Java'), ('2', 'Python')]

#也可以使用如下方法对值进行排序，先使用zip进行反转
sorted(zip(prices.values(),prices.keys()))

#[(10.75, 'FB'), (37.2, 'HPQ'), (45.23, 'ACME'), #(205.55, 'IBM'), (612.78, 'AAPL')]

#说明:如果存在values相同的情况下，则会按照key的大小进行排序。如下：
prices = {'ACME': 45.23, 'AAPL': 612.78, 'IBM': #612.78, 'HPQ': 37.20,'FB': 10.75 }
sorted(zip(prices.values(),prices.keys()))
#[(10.75, 'FB'), (37.2, 'HPQ'), (45.23, 'ACME'), (612.78, 'AAPL'), (612.78, 'IBM')]
```

### 10、成员运算in和not in

```python
# dic之成员运算in和not in,只会判断key是否存在
dic = {'a': 1, 'b': 2}

print('a' in dic) #True
print(1 in dic) #False
```

### 11、获取字典相同元素

```python
#获取两个字典相同的键、值或者items。可以通过集合运算的方式获取。
dic_a = {'x':1,'y':2,'z':3}
dic_b = {'w':10,'x':11,'y':2}

dic_a.keys() & dic_b.keys()
#{'x', 'y'}
dic_a.keys() - dic_b.keys()
#{'z'}
dic_a.items() & dic_a.items()
#{('z', 3), ('x', 1), ('y', 2)}
```