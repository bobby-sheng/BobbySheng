---
title: "asyncio使用介绍"
date: 2023-11-06
lastmod: 2023-11-06
tags:
  - Python
keywords:
  - Python
description: "asyncio编写的程序可以在单线程中实现并发处理，这使得它非常适合处理IO密集型任务。在asyncio中，可以使用async/await关键字定义协程，协程可以通过事件循环的调度来实现并发执行。"
cover:
    image: "img/python001.png"
---

# async 语法

```Bash
import asyncio

# 带asunc开头的函数为协程函数
async def work(num):
    # 模拟逻辑运行时间,不懂await asyncio.sleep(1)的没事，这就是一个asyncio的等待方法
    await asyncio.sleep(1)
    return num + 1

# async协程函数的调用
work_data = asyncio.run(work(3))
print(work_data)

运行结果为：[4, 5]
运行时间为：1 s
```

# async 函数的嵌套

```Bash
import asyncio
import time
import aiofiles
import yaml

# aiofiles为异步上下文读取文件的方法
async def read_file(file_dir):
    async with aiofiles.open(file_dir, 'r', encoding='utf-8') as file:
        # await等待读取完成并且获取返回值给到data,如果不加await是获取不到返回值的
        data = await file.read()
        yaml_data = yaml.load(data, Loader=yaml.FullLoader)
        return yaml_data


# await 也可以执行异步函数，await会等待函数执行完成，会阻塞，单独await的调用函数不是协程，为串行同步任务
async def main(file_dir):
    # 串行同步，被await堵塞
    read_data = await read_file(file_dir)
    read_data1 = await read_file(file_dir)

    # creat_task，事件循环不会堵塞 这两个是并发执行
    task1 = asyncio.create_task(read_file(file_dir))
    task2 = asyncio.create_task(read_file(file_dir))
    read_data = await task1
    read_data1 = await task2

    # 协程并发,返回的是一个列表值，所有的返回都写入到列表
    task = [asyncio.create_task(read_file(file_path)) for file_path in file_dir]
    data = await asyncio.gather(*task)

    return data

# async协程函数的调用
t1 = time.time()
work_data = asyncio.run(main(3))
print(f"运行结果为：{work_data}")
print(f"运行时间为：{int(time.time() - t1)} s")
```

# async 不同函数异步并发使用

```Bash
import asyncio
import time

# 带asunc开头的函数为协程函数
async def work(num):
    # 模拟逻辑运行时间,不懂await asyncio.sleep(1)的没事，这就是一个asyncio的等待方法
    await asyncio.sleep(1)
    return num + 1

# 带asunc开头的函数为协程函数
async def work2(num):
    await asyncio.sleep(2)
    return num + 2

async def main(num):
    # 异步执行方法，asyncio.gather，把协程函数写入，这两个方法会并发执行
    # 存入不同的协程对象，达到异步的效果
    task = [asyncio.create_task(work(num)),asyncio.create_task(work2(num))]
    data = await asyncio.gather(*task)
    return data

# async协程函数的调用
t1 = time.time()
work_data = asyncio.run(main(3))
print(f"运行结果为：{work_data}")
print(f"运行时间为：{int(time.time() - t1)} s")

运行结果为：[4, 5]
运行时间为：2 s
# 安装正常执行的逻辑，应该需要执行3s,异步只拿了最后的结果
```

# async 同函数异步并发使用

```Bash
import asyncio
import time

# 带asunc开头的函数为协程函数
async def work(num):
    # 模拟逻辑运行时间,不懂await asyncio.sleep(1)的没事，这就是一个asyncio的等待方法
    await asyncio.sleep(1)
    return num + 1

async def main(num):
    # 同一个协程函数，跌倒传入不同的参数，生成事件循环列表，异步并发执行。
    task = [asyncio.create_task(work(i)) for i in range(num)]
    # 使用`create_task()`函数创建任务的方式可以同时执行多个协程函数
    data = await asyncio.gather(*task)
    return data

# async协程函数的调用
t1 = time.time()
work_data = asyncio.run(main(3))
print(f"运行结果为：{work_data}")
print(f"运行时间为：{int(time.time() - t1)} s")

运行结果为：[1, 2, 3]
运行时间为：1 s
# 安装正常执行的逻辑，应该需要执行3s,因为我传入了3个值，
#每个值执行等待1s，但是使用了异步方法，并发执行只需要1s
```

# aiofiles 文件写入的案例

```Bash
import aiofiles
import asyncio

async def write_to_file(file_dir, content):
    async with aiofiles.open(file_dir, 'w') as file:
        await file.write(content)

async def main():
    file_dir = 'path/to/file.txt'
    content = 'Hello, World!'
    await write_to_file(file_dir, content)

asyncio.run(main())
```

# 并发编程参考案例

```Bash
async def get_yaml_data(file_dirs):
    """
    并发处理yaml数据并写入缓存
    """
    # 第一步异步并发读取所有路径文件内容
    read_data_list = [asyncio.create_task(read_file(file_dir)) for file_dir in file_dirs]
    # 第二步把获取到的文件内容，迭代传入到process_include函数，生成task事件循环协程对象列表
    process_data_list = [asyncio.create_task(process_include(read_data)) for read_data in await asyncio.gather(*read_data_list)]
    # 第三步获取process_include返回值列表，传入异步函数case_process时间任务对象列表
    case_data_list = [asyncio.create_task(CaseData().case_process(process_data, case_id_switch=True)) for process_data in
             await asyncio.gather(*process_data_list)]
    # 第四步把一样，传入时间任务函数列表，使用await asyncio.gather()并发执行
    write_case_list = [asyncio.create_task(write_case_process(write_case)) for write_case in await asyncio.gather(*case_data_list)]
    results = await asyncio.gather(*write_case_list)
    return results
    
    
    # 执行
t1 = time.time()
api_file = []
case_file = []
file_dirs = get_all_files(file_path=ensure_path_sep("\\data"), yaml_data_switch=True)
for i in file_dirs:
    if "\\data\\api" in i:
        api_file.append(i)
    else:
        case_file.append(i)
asyncio.run(get_yaml_data(api_file))
yaml_data = asyncio.run(get_yaml_data(case_file))
print(len(_cache_config))
print(time.time() - t1)
    
# 总结：拆分步骤，把函数需要的值设置为列表，迭代生成事件循环，并发处理。以此类推，直到完成全部逻辑
# 那么需要使用并发的函数都需使用async def 开头，await 执行并获取结果
```