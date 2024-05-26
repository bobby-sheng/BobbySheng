---
title: "Python OOP编程范式"
date: 2024-05-26
lastmod: 2024-05-26
tags:
  - Python
keywords:
  - Python
description: "Python OOP编程范式"
cover:
    image: "https://telegraph-image-f19.pages.dev/file/b58433d3a3f238c52fcd4.jpg"
---
# 背景
在公司自己写了一个工具,在二次需求增加的时候,发现自己写的代码都是使用的函数流程式的编写,在开发需求的过程中并不舒服,没有很好等结构,流程式等开发.可能和我写的工具大部分都是脚本式的有关系,习惯了一个py文件解决问题,遇到稍微大点的需求流程,我应该梳理出公共点,设计基类与各种子类,实现需求功能.加深下面对对象编程的习惯.其实就是在开发之前先梳理整个流程场景,要非常的细,才能在之前的基础上去抽出公共点,编写类和函数

# 如何去使用OOP编写程序
你可以遵循以下步骤来创建一个结构化、可维护和可扩展的代码库：
## 确定对象和类
识别现实世界中的对象和概念，并将它们映射到程序中的类。每个类应该代表一个特定的实体或概念，例如Person、Car、Order等。
## 定义属性和方法
为每个类定义属性（数据）和方法（行为）。属性是类的变量，而方法是类的功能，可以操作这些变量。
```python
class Person:
    def init(self, name, age):
        self.name = name  属性
        self.age = age    属性
    def introduce(self):  方法
        print(f"Hello, my name is {self.name} and I am {self.age} years old.")
```
## 实现封装
使用封装来隐藏对象的内部状态，只通过方法暴露必要的接口。这有助于保护数据不被外部直接修改，从而避免潜在的错误。
```python
class BankAccount:
    def init(self, account_number, balance=0):
        self.__account_number = account_number
        self.__balance = balance
    def deposit(self, amount):
        self.__balance += amount
    def withdraw(self, amount):
        if amount  self.__balance:
            print("Insufficient funds")
        else:
            self.__balance -= amount
    def get_balance(self):
        return self.__balance
```
## 使用继承
考虑是否可以创建一个基类（父类），它包含通用的属性和方法，然后通过继承来创建更具体的子类（子类）。这有助于代码复用和建立类之间的层次结构。
```python
class Vehicle:
    def init(self, make, model):
        self.make = make
        self.model = model
    def start(self):
        print("The vehicle has started.")
class Car(Vehicle):
    def init(self, make, model, year):
        super().init(make, model)
        self.year = year
    def start(self):
        super().start()  调用父类方法
        print(f"The {self.year} {self.make} {self.model} has started.")
```
## 利用多态
通过多态，你可以使用统一的接口来处理不同类型的对象。这使得代码更加灵活和可扩展。
```python
def vehicle_action(vehicle):
    vehicle.start()  多态性：不同的Vehicle对象可以有不同的start方法
car = Car("Toyota", "Camry", 2021)
vehicle_action(car)  调用Car类的start方法
```
## 抽象化
识别并定义一组具有共同行为的对象的抽象特性。使用抽象类来为这些对象提供一个公共的接口。
```python
from abc import ABC, abstractmethod
class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass
class Dog(Animal):
    def make_sound(self):
        print("Woof!")
class Cat(Animal):
    def make_sound(self):
        print("Meow!")
```
## 设计模式
考虑使用设计模式来解决常见的软件设计问题。设计模式提供了经过验证的解决方案，可以帮助你写出更清晰、更一致的代码。
## 编写可重用的代码
尽量编写可重用的代码，避免重复。这可以通过继承、多态和设计模式来实现。
## 测试和验证
为每个类和方法编写单元测试，确保它们按预期工作。这有助于及早发现错误并保持代码质量。
## 持续迭代和重构
在开发过程中，不断地迭代和重构代码，以改进设计、提高性能和适应需求变化。
通过遵循这些步骤，你可以使用OOP来设计一个健壮、灵活且易于维护的程序，OOP不仅仅是一种编程技术，更是一种思考和解决问题的方式。
