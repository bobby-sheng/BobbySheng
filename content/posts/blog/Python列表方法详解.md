# Python列表方法详解

2022-07-21 · bobby

## 笔记背景

好记性不如烂笔头，在需要的时经常断片忘记基础方法，写这笔记目的一是加深印象，二是实在记不得也不需要去外网寻找找影响效率。

## 一、列表常用方法

### 1、索引取值-list[index]

按索引取值（正向取值+反向取值），即可存也可以取

```python
# list之索引取值
name_list = ['nick', 'jason', 'tank', 'sean']
name_list[0] = 'nick handsom' 存入到第一个索引位置中
# name_list[1000] = 'tank sb'  # 报错

#"nick handsom"
pring name_list[0]
```

### 2、切片

切片操作基本表达式：[start_index：stop_index：step] start 值

#### 2.1、获取单个元素

```python
list =["red","green","blue","yellow","white","black"]

#red
print(list[0])

# black
print(list[-1])
```

#### 2.2、获取列表对象

```python
list = ["red","green","blue","yellow","white","black"]
'''
从左往右获取索引,['red', 'green', 'blue', 'yellow', 'white', 'black']
'''
print(list[:])
print(list[::])
print(list[::1])
'''
从右往左获取索引（反向索引）,['black', 'white', 'yellow', 'blue', 'green', 'red']
'''
print(list[::-1])
```

#### 2.3、获取列表部分的值

（1）正向索引

```python
list = ["red","green","blue","yellow","white","black"]
'''
反向索引：step为负数
'''
# 正向索引：start_index为0到end_index为6
print(list[0:6]) # ['red', 'green', 'blue', 'yellow', 'white', 'black']

# start_index没有填写，默认从第一个开始,一直取到end_index=6
print(list[:6]) # ['red', 'green', 'blue', 'yellow', 'white', 'black']

# step没有填写，默认是1，start_index为0,一直取到end_index=2
print(list[0:2])  #['red', 'green']

# step没有填写，默认是1，start_index为1,一直取到end_index=4
print(list[1:4])  # ['green', 'blue', 'yellow']

# start_index为1,一直取到end_index=5，step是2
print(list[1:5:2])  # ['green', 'yellow']
```

（2）反向索引

```python
list = ["red","green","blue","yellow","white","black"]
'''
反向索引：step为负数
'''
print("反向索引=============")
# step=1，反向索引，从start_index=-6开始，一直取到end_index=0为止。
print(list[-6::])  #['red', 'green', 'blue', 'yellow', 'white', 'black']

# step=-1，反向索引，从start_index=3开始，一直取到end_index=0为止。
print(list[3:0:-1])  #['yellow', 'blue', 'green']

# step=-2，反向索引，从start_index=6开始，一直取到end_index=0为止。
print(list[6::-2])  #['black', 'yellow', 'green']

# step=-3，反向索引，从start_index=5开始，一直取到end_index=2为止。
print(list[5:2:-3])  #['black']

# step=-1，反向索引，从start_index=-3开始，一直取到end_index=-5为止。
print(list[-3:-5:-1])  #['yellow', 'blue']

# start_index > end_index时，取出的结果为空

print(list[4:2])  #[]
print(list[-5:-3:-1])  # []
```

#### 2.4、列表多层切片

```python
'''多层切片'''
list = ["red","green","blue","yellow","white","black"]
# 链式列表切片
print(list[:6][2:5][-1:])

'''上边的链式列表与下边的步骤是相等的'''
list2 = list[:6]

# ['red', 'green', 'blue', 'yellow', 'white', 'black']
print(list2)
list3 = list2[2:5]

# ['blue', 'yellow', 'white']
print(list3)
list4 = list3[-1:]

# ['white']
print(list4)
```

### 3、长度-len(list)

```python
# list之长度
name_list = ['nick', 'jason', 'tank', 'sean']

# 4
print(len(name_list))

# list之多维列表长度
name_list = ['nick', 'jason', 'tank', 'sean',["1","2","3"]]

# 3
print(len(name_list[4]))
```

### 4、成员运算in和not in

```python
# list之成员运算in和not in
name_list = ['nick', 'jason', 'tank', 'sean']

#False
print('tank sb' in name_list)

#Ture
print('nick handsome' not in name_list)
```

### 5、追加值-append（值）

```python
# list之追加值
name_list = ['nick', 'jason', 'tank', 'sean']
name_list.append('tank sb')

#['nick', 'jason', 'tank', 'sean','tank sb']
print name_list
```

### 6、删除值-del list[index]

```python
# list之删除值
name_list = ['nick', 'jason', 'tank', 'sean']
del name_list[2]

#['nick', 'jason', 'sean','tank sb']
print name_list
```

### 7、列表循环取值

```python
# list之列表循环取值
name_list = ['nick', 'jason', 'tank', 'sean']

第一种：for name in name_list:
    		print(name)
        
第二种：li=[i for i in name_list]
```

## 二、列表内置方法

### 1、列表插入-insert(index)

```python
#使用方法insert(index,list)

#注意：如果索引超出范围,则如果索引为正,则该项目将追加到末尾；如果索引为负,则将其追加到开头，没有例外.
>>> my_list = ['a', 'b']
>>> my_list.insert(5, 'item')
>>> my_list
['a', 'b', 'item']

>>> my_list = ['a', 'b']
>>> my_list.insert(-3, 'item')
>>> my_list
['item', 'a', 'b']
```

### 2、列表删除-pop(index)

```python
#使用方法 list.pop(),index为空默认删除最后一个值[-1]

#注意：此方法会返回删除数据的值
name_list = ['nick', 'jason', 'tank', 'sean']
name_list.pop(1)

#['nick', 'tank', 'sean']
print(name_list)
```

### 3、列表删除-remove(值)

```python
# 使用方法list.remove(值),会删除匹配到的第一个值

name_list = ['nick', 'jason', 'jason','tank', 'sean']
name_list.remove('jason')

#['nick', 'jason','tank', 'sean']
print name_list
```

### 4、列表重复值统计-count(值)

```python
# 使用方法list.count(值),会统计列表中值的个数

name_list = ['nick', 'jason', 'jason','tank', 'sean']

# 2
print name_list.count('jason')
```

### 5、列表值的索引位置-index(值)

```python
# 使用方法list.index(值),会查找出列表中匹配到的第一个值的位置

name_list = ['nick', 'jason', 'jason','tank', 'sean']

# 1
print name_list.index('jason')
```

### 6、列表清除内容-clear()

```python
# 使用方法list.clear(),清除列表内容

name_list = ['nick', 'jason', 'jason','tank', 'sean']
name_list.clear()

# []
print name_list
```

### 7、列表复制-copy()

```python
# 使用方法list.copy(),清除列表内容

name_list = ['nick', 'jason', 'jason','tank', 'sean']
name_list_copy=name_list.copy()

# ['nick', 'jason', 'jason','tank', 'sean']
print name_list_copy
```

### 8、列表合并-extend(list2)

```python
# 使用方法list1.extend(list2),合并两个值列表为一个

name_list = ['nick', 'jason', 'jason','tank', 'sean']
name_list_copy=["nick_aaaa"]
name_list.extend(name_list_copy)

# ['nick', 'jason', 'jason','tank', 'sean',"nick_aaaa"]
print name_list
```

### 9、列表反转-reverse()

```python
# 使用方法list.reverse(),列表反转

name_list = ['nick', 'jason', 'jason','tank', 'sean']
name_list.reverse()

# ['sean', 'tank', 'jason','jason', 'nick']
print name_list
```

### 10、列表**排序**-sort()

```python
# 使用方法list.sort(),使用sort列表的元素必须是同类型的

#列表内的元素，按照由小到大顺序进行排序。
list_val = [12,32,9,89,10,3,100,45,56]
list_val.sort()

# [3, 9, 10, 12, 32, 45, 56, 89, 100]
print(list_val)

#列表内的元素，按照由大到小顺序排序。
list_val = [12,32,9,89,10,3,100,45,56]
list_val.sort(reverse=Ture)

# [100, 89, 56, 45, 32, 12, 10, 9, 3]
print(list_val)
```