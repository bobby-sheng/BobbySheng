# Pytest详解

2022-08-25 · bobby

## 一、pytest概念

pytest是python的第三方测试框架，与python自带的unittest框架类似，但是比unittest框架要简洁，方便。

## 二、pytest特点

pytest是非常成熟的测试框架，主要有一下几个特点

1、非常容易上手，有丰富的文档

2、可以通过skip跳过用例

3、可以通过make标签区分用例并且可以通过make执行

4、可以控制setup初始方法执行的对象是模块还是方法

5、兼容unittest或者note框架

6、支持执行部分用例

7、支持通过pytest-cache缓存执行失败用例

## 三、pytest安装

```python
#python直接使用pip导入即可
pip install pytest
```

## 四、pytest 执行

```python
#1、pytest可以通过指定文件目录，只执行该目录下的testcase
#	通过空格间隔多个文件。后面还可以在加一层make筛选
pytest test1   pytest test1 test2.py
```

### pytest 执行参数

```python
-v 输出更详细的信息；
-s 输入调试信息；
-n 多线程 需要安装xdist库
-m 执行标签
--reruns 失败用例重跑
--html 生成简易报告
--last-failed --last-failed-no-failures all 基于失败缓存重跑，无缓存就执行全部
--alluredir ../allure-results  allure报告存储地址
pytest -vs --reuns 2
#模板 pytest -v -s -l tempest -m make --last-failed --last-failed-no-failures all -n 14 --reruns 0 --show-capture=stderr --dist=loadfile --durations=30 --alluredir ../allure-results
```

### pytest make执行（-m）

```python
#2、pytest make执行（-m）
@pytest.mark.smoke
	def aa():
        pass
执行：pytest test1 -m smoke
```

### pytest 执行顺序

```python
#pytest顺序执行，需要给用例写上make装饰器方法
@pytest.make.run(order=1)
	def aa():
        pass
```

## 五、pytest setup初始

```python
#pytest框架在执行用例时的初始化分为了4个层面
1、模块级：setup_module/teardown_module  #每个.py文件中存在就会执行一次
2、函数级：setup_function/teardown_function #函数可以理解为不在calss类种的def方法，使用每个函数都会执行
3、类级:setup_class/teardown_class #class类只执行一次
4、方法级：setup_method/teardown_method #class类中的def方法每个def都会执行
```

## 六、@pytest.fixture初始

```python
#@pytest.fixture()和setup类似，都是初始方法，不过是以装饰器的形式去使用
#@pytest.fixture(scope="作用域", params="数据驱动",autouse="自动执行",ids="参数别名",name="fixture别名")
1、模块级：@pytest.fixture(scope="session",autouse="ture")  #多个py文件可以调用一次，存放在conftest.pyw文件中，作用域不同
2、模块级：@pytest.fixture(scope="module",autouse="ture")  #每个.py文件中存在就会执行一次
3、函数级：@pytest.fixture(scope="function",autouse="ture")  #函数可以理解为不在calss类种的def方法，使用每个函数都会执行，如果scope参数为空默认为此
4、类级:@pytest.fixture(scope="class",autouse="ture") #class类只执行一次
#fixture中存在下级可以调用上级，上级无法向下兼容，可以做到流程管理，举例：module可以调用session,需要配conftest.py文件中，每个子级文件都可以创建conftest.py文件，作用域不同。可以存放登录、清理资源等方法。
```

## 七、@pytest ddt参数传递

pytest .mark.parametrize()

```python
#pytest 内置装饰器 @pytest.mark.parametrize 可以让测试数据参数化，把测试数据单独管理，类似 ddt 数据驱动的作用，方便代码和测试数据分离。
@pytest.mark.parametrize('x,y',[(1,2),(3,4)])
def test_sum(x,y):
    sum = x + y
    print(sum)
if __name__ =="__main__":python
    pytest.main(['test_sample.py','-s'])
  3
  7
```

## 八、pytest断言

```python
#常用断言，用的是python自带的断言。这块应该没有unittest好用
assert xx 判断xx为真
assert not xx 判断xx不为真
assert a in b 判断b包含b
assert a==b 判断等于b
assert a!=b 判断a不等于b
#异常断言 pytest.rauses。详细断言异常
def test_zero_division_long():
    with pytest.raises(ZeroDivisionError) as excinfo:
        1 / 0
    # 断言异常类型 type
    assert excinfo.type == ZeroDivisionError
    # 断言异常 value 值
    assert "division by zero" in str(excinfo.value)
#封装的unittest异常断言
  self.assertRaises(
            lib_exc.NotFound,
            self.aaa,
            **kwagr)
```

## 九、pytest.ini

```python
#ini文件需要放在项目根目录中。可以把一些命令参数填写进去，也可以忽略告警、设置固定时间、以及写入make不提示告警
[pytest]
addopts = -rsxX -l -strict --tb=short   addopts后面可以接pytest运行时的参数，执行时就不需要填写参数了
addopts = -p no:warnings  忽略告警
env =
    PYTHONHASHSEED=0  并发执行用例时程序线程之间的数量不相等导致报错，可以使用这个命令
timeout = 2400  需要导入pytest_timeout插件，每条用例不包含前置执行时间超过2400s直接停止报错。控制执行时间
markers = skipcase
    mistake
    secret  写入make，不会告警
    
#pytest.ini还有很多参数，我只用到这些部分，记录一下
```

## 十、pytest_allure

```python
安装命令：pip install allure-pytest
使用方法	参数值	参数说明
@allure.epic()	epic描述	敏捷里面的概念，定义史诗，往下是feature
@allure.feature()	模块名称	功能点的描述，往下是story
@allure.story()	用户故事	用户故事，往下是title
@allure.title(用例的标题)	用例的标题	重命名html报告名称
@allure.testcase()	测试用例的链接地址	对应功能测试用例系统里面的case
@allure.issue()	缺陷	对应缺陷管理系统里面的链接
@allure.description()	用例描述	测试用例的描述
@allure.step()	操作步骤	测试用例的步骤
@allure.severity()	用例等级	blocker，critical，normal，minor，trivial
@allure.link()	链接	定义一个链接，在测试报告展现
@allure.attachment()	附件	报告添加附件
#1、生成报告本地是获取本地文件，使用命令生成。allure generate allure(生成的allure报告文件名) allure open allure-report（打开html报告）
#2、jenkins是在宿主机安装pip3 install allure-pytest或者在docker中安装pip3 install allure-pytest。安装完成后在jenkins安装插件，配置好，使用shell命令 pytest --alluredir ./report生成。详细可以看：
#https://www.icode9.com/content-4-828260.html
```

### 总结

pytest还有很多自带的装饰器以及第三方插件，我这里写的只是冰山一角，这些足够平时的工作。下次遇见再补充上来。

相比较于unittest框架还是好用的，下面例举一点优缺点

```python
1、测试报告不同
unittest支持 HTMLTestRunner   BeautifulRepor
pytest 支持 allure
2、前置不同
unittest前置只有两种，setup与setupclass
pytest有两种方法，5中作用域
3、断言不同
unittest使用断言是self.assertinto()
pytest是python自带的断言，直接使用 assert
4、用例收集不同
unittest需要自己手动写代码收集测试套件
pytest自动收集
5、并发不同
unittest无并发插件，需要手动写并发多线程
pytest有并发插件
```