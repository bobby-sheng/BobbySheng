# python文档读写方法

2022-07-14 · bobby

### 一、文档读写实用方法

**1、readline()函数**

解释：此函数读取文件默认打印第一行，后面可以接参数打印字符个数

```python
with open(p, 'rt') as f:
    rows = f.readline()
    print rows
```

**2、readlines()函数**

file.readline()[index]

解释：此函数把文件作列表全部读取出来，可通过for循环获取每一行的值

```python
with open(p, 'rt') as f:
    rows = f.readlines()
    for i, line in enumerate(rows):
        print i
```

**2、read()函数**

解释：此函数把文件样式原封不动的打印出来

```python
with open(p, 'rt') as f:
    rows = f.read()
    print rows
```

### 二、打开文件模式解释

```python
### 常用模式打开文件
# 1.r模式
# 2.w模式:写入的文件不存在会自动创建，每一次写入都会覆盖前面的内容
# 3.a模式：与w模式一样，但是内容会追加
# 4.b模式：字节读取+字节写入

### 其他模式模式
# 1.r+--打开文件用于读写，文件指针会放在文件开头
# 2.rb+--二进制打开文件用于读写，文件指针会放在文件开头
# 3.w+--打开文件用于读写，并且从头开始编辑，会覆盖原内容
# 4.wb+--二进制打开文件用于读写，并且从头开始编辑，会覆盖原内容
# 5.ab--二进制打开用于追加，指针放末尾，只能写
# 6.ab+--二进制打开文件用于追加，指针放末尾
# 7.a+--打开文件读写，指针放末尾，文件存在追加模式，不存在新建
```

### 三、文件读写案例

**案例一**

解释：打开文件，获取文件所在行之后，赋值。在打开文件写入变量中的值

```python
with open(p, 'rt') as f:
    rows = f.readlines()
    for i, line in enumerate(rows):
        if content[3] in line:
            a = i
            for k in range(a, a+60):
                if "expect_return = " in rows[k]:
                    rows[k] = "        expect_return =" + content[2]
                    break
log.info("写入")
with open(p, 'w+') as w:
	w.writelines(rows)                    
        
```

**案例二**

解释：一次性打开多个文件，实现文件的快速拷贝。

```python
with open('32.txt', 'rb') as fr, \
        open('35r.txt', 'wb') as fw:
    f.write(f.read())
```

**案例三**

```python
import os

with open('37r.txt') as fr, \
        open('37r_swap.txt', 'w') as fw:
    data = fr.read()  # 全部读入内存,如果文件很大,会很卡
    data = data.replace('tank', 'tankSB')  # 在内存中完成修改

    fw.write(data)  # 新文件一次性写入原文件内容

# 删除原文件
os.remove('37r.txt')
# 重命名新文件名为原文件名
os.rename('37r_swap.txt', '37r.txt')
print('done...')
```

**案例四**

```python
import os

with open('37r.txt') as fr,\
        open('37r_swap.txt', 'w') as fw:
    # 循环读取文件内容，逐行修改
    for line in fr:
        line = line.replace('jason', 'jasonSB')
        # 新文件写入原文件修改后内容
        fw.write(line)

os.remove('37r.txt')
os.rename('37r_swap.txt', '37r.txt')
print('done...')
```

### 四、总结

修改文件内容的思路为：以读的方式打开原文件，以写的方式打开一个新的文件，把原文件的内容进行修改，然后写入新文件，之后利用os模块的方法，把原文件删除，重命名新文件为原文件名，达到以假乱真的目的