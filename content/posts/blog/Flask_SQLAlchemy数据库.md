---
title: "Flask_SQLAlchemy数据库 "
date: 2022-10-31
lastmod: 2022-10-31
tags:
  - docker
  - obsidian
keywords:
  - docker
  - obsidian
  - centos
  - piclist
description: "flask-SQLAlchemy对sqlite数据库的连接与增删改查"
cover:
---

## 简介

```bash
flask-SQLAlchemy对sqlite数据库的连接与增删改查
```

## flask 与sqlite的创建与连接

```bash
#参考地址
https://www.py.cn/kuangjia/flask/24552.html
```

## 单表操作

```bash
# 参考地址
https://blog.csdn.net/weixin_45618073/article/details/125137141
```

### 增加

```bash
#单个数据增加
stu=Student(name="张三",gender="男",phone="1452")
db.session.add(s1)
db.session.commit() #除了查询，都要commit

#多个数据增加
stu=Student(name="张三",gender="男",phone="1452")
stu2=Student(name="李四",gender="男",phone="1445")
stu3=Student(name="王五",gender="男",phone="1465245")
stu4=Student(name="老王",gender="男",phone="145245")
db.session.add_all([stu,stu2,stu3,stu4])
db.session.commit() #除了查询，都要commit
```

### 查询

```bash
#单个数据查询id为1的数据表，返回一个对象
stu=Student.query.get(1)
print(Student.name)

#查询表中所有数据，返回一个列表，值为数据对象
stu=Student.query.all()
for i in stu:
    print(Student.name) #打印表所有此字段值

#(类名.属性名 条件操作符 条件) 过滤特定条件,返回的是query对象
Student.query.filter(Student.id=="1").first() #后面可以接.all() 表示取全部，.first() 表示取第一个值
for i in stu:
    print(表.列) #打印列表中数据所有此字段值
    
#(关键字参数对) 单条件查询,条件必须关键字参数,而且and连接
Student.query.filter_by(id="1").first() #后面可以接.all() 表示取全部，.first() 表示取第一个值，还可以继续接条件.filter(列=值)，或者.delete
for i in stu:
    print(Student.name) #打印列表中数据所有此字段值
```

### 修改

```bash
#第一种，直接拼接在查询后面
Student.query.filter(Student.id=="1").first().update({"列":"值"})
print(stu) #返回修改了多少条数据的数量
db.session.commit() #除了查询，都要commit

#第二种 改单个
Student.query.filter(Student.id=="1").first()
stu.列=新值 #直接赋予新值
db.session.add(s1) #修改值的需要增加add方法
db.session.commit() #除了查询，都要commit

#第二种 循环改多个
Student.query.filter(Student.id=="1").all()
for i in stu:
    i.列=新值 #直接赋予新值
    db.session.add(s1)
db.session.commit() #除了查询，都要commit
```

### 删除

```bash
#第一种，直接拼接在查询后面
stu=表名.query.filter(列=值).delete({"列":"值"})
print(stu) #返回修改了多少条数据的数量
db.session.commit() #除了查询，都要commit
```

## 多表操作

### 一对多表设置关联

```bash
# 多表操作必须创建关联，假设A表关联B表，A表中需要创建列关联B，一放使用db.relationship("B表名",bockref("A表"))。多方B表需要创建外键db.ForeignKey("所属表中的关联字段")关联A表
#db.relationship是和db.ForeignKey配合使用的，用来描述一对多关系。
#在一对多中，db.ForeignKey写在“多”方，关联“一”方的某一个属性。
#db.relationship写在“一”方，“一”方通过该属性可以取出一个列表，列表元素为所有对应的“多”方的对象。
#db.relationship中的backref是“多”方使用的。“多”方通过该属性（即backref传入的字符串）可以访问到其对应的“一”方对象。

class Student(db.Model):
    """
    学生表
    """
    __tablename__ = 'student'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    gender = db.Column(db.String(100))
    phone = db.Column(db.String(100))
    grades = db.relationship("Grade", backref="student") #反向给到成绩表数据
    
class Grade(db.Model):
    """
    成绩表
    """
    __tablename__ = 'grade'

    id = db.Column(db.Integer, primary_key=True)
    grade = db.Column(db.String(100))
    student_id = db.Column(db.String(100), db.ForeignKey("student.id")) # 关联学生表的id
```

### 查询

```bash
# 一访问多
stu = Student.query.filter(Student.name == "张三").all()
for i in stu:
    print(i.name)
    for k in i.grades:
        print(k.grade)
        
# 多访问一
gra=Grade.query.filter_by(student_id ="1").all()
for i in gra:
    print(i.grade,i.student.name)
```

## 多对多表设置关联

## 表

```bash
# 学生可以存在多个课程，课程可以存在多个学生。多对多关系
class Student(db.Model):
    """
    学生表
    """
    __tablename__ = 'student'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    gender = db.Column(db.String(100))
    phone = db.Column(db.String(100))
    grades = db.relationship("Grade", backref="student")
    course = db.relationship("Course", secondary="student_to_course", backref="students")
    # secondar比一对多多了这个参数，中间表参数
    # backref可以随便填，反向表获取使用
class StudentToCourse(db.Model):
    """
    中间表放外键
    """
    __tablename__ = 'student_to_course'
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.String(100), db.ForeignKey("student.id")) #外键，数据库存在此字段
    course_id = db.Column(db.String(100), db.ForeignKey("course.id")) #外键，数据库存在此字段


class Course(db.Model):
    """
    课程表
    """
    __tablename__ = 'course'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    grades = db.relationship("Grade", backref="course")
    techer_id = db.Column(db.String(100), db.ForeignKey("techer.id"))
```

### 添加关联数据

```bash
# 多对多，给一个学生增加课程
# 先查询出学生
stu = Student.query.get(1)
print(stu.name)
# 给这个学生加课程,关联会添加到中间表中。显示id都为1
cou = Course.query.filter(Course.id == 1).all()
stu.courses = cou
db.session.add(stu)
db.session.commit()

# 多对多增加关联，给多个学生增加课程
# 查询学生表
stu = Student.query.filter(Student.id > 2).all()
print(stu)
# 查询课程表
cou = Course.query.filter(Course.id > 1).all()
print(cou)

for i in stu:
    i.courses = cou
    db.session.add(i)
    db.session.commit()
```

### 查询关联数据

```bash
#多对多查询，通过学生表查询课程表
stu=Student.query.get(1)
for i in stu.courses:
    print(i.name)

    
#多对多查询，查询出来的对象不是一个列表。非列表通过课程表查询学生表
cou = Course.query.get(2)
print(cou)
for i in cou.students:
    print(i.name)
    
#多对多查询，查询出来的对象是一个列表。通过课程表查询学生表
cou = Course.query.filter(Course.name == "语文").all()
print(cou)
for i in cou:
    for k in i.students:
        print(k.name)
```