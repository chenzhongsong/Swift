//
//  main.swift
//  Swift-面向对象上-中-下
//
//  Created by chenzhongsong on 16/3/15.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation
//              Swift 面向对象基础（上）

/*
            Swift中的枚举
*/

/*
1.面向对象的核心：类和对象
2.面向对象编程的三大特征：封装、继承和多态
3.Swift可以定义枚举、结构体和类三种面向对象的类型
4.支持定义存储属性、计算属性、方法、下标、构造器和嵌套类型
*/


/* //枚举
1.用于管理一组有限的值得集合
2.支持计算属性
3.支持实例方法和类方法
4.支持定义构造器来完成初始化
5.支持扩展和协议
*/

//枚举定义
/*
    enum 枚举名 {
        //使用case关键字列出所有枚举值
        //枚举的其他成员

    }
*/
//定义枚举
enum Season {
    case Spring
    case Summer
    case Fall
    case Winter
}
//1.使用一个case列举所有的值
enum Season2 {
    case Spring, Summmer, Fall, Winter
}

//2.使用枚举声明变量
var weather: Season
weather = Season.Spring
weather = .Summer
//print(weather)

//3.枚举值和Switch语句
var chooseDay = Season.Fall
//使用switch语句判断枚举值
//switch chooseDay {
//case .Spring:
//    print("春天")
//case .Summer:
//    print("夏天")
//case .Fall:
//    print("秋天")
//case .Winter:
//    print("冬天")
//default:
//    print("其他")
//}
//Switch 中的case没有覆盖枚举值，必须添加default语句

//4.原始值
/*
    enum 枚举名:原始值类型 {
        case 枚举值 = 原始值
    }
    Swift不要求对每个枚举值都指定原始值，Swift可以推断，有些例外
*/
enum Weekday: Int {
    case Mon, Tur, Wen = 3, Thur, Fri, Sat, Sun
}
//必须都指定原始值,这时Swift不会推断
enum Season3:Character {
    case Spring = "春"
    case Summer = "夏"
    case Fall = "秋"
    case Winter = "冬"
}
//rawValue 获取原始值
//print(Weekday.Fri.rawValue)

//根据原始值获取枚举值
//使用了一个init?(rawValue:)的构造器  可选类型
var mySeason = Season3(rawValue: "春")
if mySeason != nil {
    switch mySeason! {
    case .Spring:
        //print("春天")
        break
    case .Summer:
        print("冬天")
    case .Fall , .Winter:
        print("秋天  冬天")
//    default:
//        print("其他")
    }
}

//5.关联值
enum Planet {
    case Earth(weight:Double, name:String)
    case Mars(density:Double, name:String, weight:Double)
    case Venus(Double, String)
    case Saturn
    case Neptune
}
var p1 = Planet.Earth(weight: 1.0, name: "地球")
var p2 = Planet.Venus(0.819, "金星")
var p3 = Planet.Mars(density: 3.15, name: "火星", weight: 0.1)

switch p3 {
    //将关联值绑定到变量或者常量来提取
case Planet.Earth(var weight, var name):
    print("此行星的名字为：\(name),质量相当于\(weight)个地球")
    //将关联值都提取为常量或者变量，只将一个var或者let 放到枚举成员之前
case let Planet.Mars(density: d, name: n, weight: w):
    print("此行星的名字为：\(n),质量相当于\(w)个地球,密度为\(d)")
default:
    break
}
/*枚举使用枚举名调用枚举值*/



/*
                Swift中的类和结构体（上）
*/


/*
1.定义类和结构体
2.创建实例
3.值类型和引用类型

类和结构体的区别：结构体不支持继承，不支持定义析构器，结构体是值类型，类是引用类型
在实际应用当中，结构体的使用并不多，重点是类的使用
*/

//1.定义类
/*
    [修饰符] class 类名 {
        零到多个构造器（init初始化方法）
        零到多个属性（存储属性和计算属性）
        零到多个方法
        零到多个下标
    }
修饰符可以是 private、public、internal、final
*/

//2.定义结构体
/*
    [修饰符] struct 结构体名 {

    }
修饰符可以是 private、public、internal 不能是final因为结构体不支持继承
*/

/*
定义属性的方法  这里主要简单介绍的是存储属性的方法
[修饰符] var或者let 存储属性名:类型名字 = 初始值
修饰符除了前面介绍的几种之外，还可以是class和static
存储属性必须给定一个初始值，要么定义的时候给定，要么构造器初始化的时候给定
*/

/*
定义构造器的语法
[修饰符] init(形参列表) {
    零到多条可执行语句组成的构造器执行体
}

修饰符可以省略 也可以是private、public、internal中的一个
*/

/*
定义方法的语法
[修饰符] func 方法名(形参列表) -> 返回值类型 {
    零到多条可执行语句
}
修饰符除了前面介绍的几种之外，还可以是class和static
swift当中也可以用修饰符，这里不再过多解释
*/

//定义一个Person类
class Person {
    var name: String = "Jack"
    var age: Int = 0
    func say(content:String) {
        print(content)
    }
}

struct Dog {
    var name: String
    var age:Int
    func run() {
        print("\(name)在奔跑")
    }
}
//创建Person类的实例
// 类的实例也可以称为类的对象，但是结构体和枚举的只能称为实例，不能称为对象
//var p:Person
//p = Person()
var p  = Person() //等价
print(p.name)
p.say("Hello World")

//创建Dog结构体的实例
var dog = Dog(name: "旺财", age: 2)
print(dog.name)
dog.run()

//值类型和引用类型
//内存里的对象可以有多个引用，即多个引用指向同一个对象
var p21 = p
p21.name = "Rose"
print(p.name)
print(p21.name)
//打印相同

//值类型
var dog2 = dog
dog2.name = "snoopy"
print(dog2.name)
print(dog.name)
//打印不同

//结构体和枚举都是值类型,值类型需要复制，所以无论是赋值还是参数传递，都需要复制，所以他们不支持继承

//结构体和枚举是值类型，类是引用类型

/*
    引用类型: 当我们创建Person实例，也即是Person对象的时候，需要相对应的内存来存储Person实例相对应的存储属性名称和年龄，那么Swift就会让引用变量p来指向相对应的实例，p只是一个引用，没有包含实际的数据，它指向的是实际的Person实例，这就是引用类型，即内存里的对象可以有多个引用，即多个引用指向同一个对象
*/

/*
    值类型: 当创建Dog这个实例的时候，这个变量就存储了Dog实例，如果把这个实例赋值给另一个变量，那么系统就会将这个实例重新复制一份，并将副本存储到新的变量中，也即是说当你对新的变量进行操作的时候，对原有变量是不会有任何影响的
*/

/*
    关于值类型和引用类型，需要注意的是，值类型需要复制，而引用类型不需要复制，记住这个最大的区别就可以额
    Swift把结构体和枚举都当做值类型来处理，所以说无论是赋值还是参数传递都需要复制，所以枚举和结构体是不
    支持继承的
*/


/*
                    类和结构体（下）
*/

/*
    1.引用类型的比较
    2.self关键词 即self在不同的位置代表的含义
    3.类和结构体的选择  因为类和结构体有很多相似的地方，什么时候用类，什么时候用结构体，最后了解

*/

/*1.引用类型的比较*/
class User {
    var name: String
    var age:Int
    init (name:String, age:Int) {
        self.name = name
        self.age = age
    }
}
var u1 = User(name: "Han", age: 32)
var u2 = User(name: "Han", age: 32)
//运算符“===”只能用于引用变量的比较，用来比较两个引用类型的变量是否指向同一个实例
//运算符“===”只能只能用于比较引用类型，并不能用于比较值类型
print(u1 === u2) //u1 与 u2 引用的不是同一对象
print(u1 !== u2)
var u3 = u1
print(u3 === u1)
//== != 也可以用于比较引用类型 用于比较引用类型时，就必须进行 运算符重载


/*2.self关键词*/

/*
    1.构造器中的self代表构造器正在初始化的实例
    2.方法中的self代表该方法的调用者
        与oc当中self的概念是相似的
*/

class Dog1 {
    func jump() {
        print("正在执行jump方法")
    }
    func run() {
        self.jump()
        //jump()//等价
        print("正在执行run方法")
    }
}
class Person1 {
    var name:String = ""
    var age:Int = 2
    //显示定义带参数的构造器
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    //定义一个info方法
    func info() {
        print("我的名字是:\(name),年龄是:\(age)")
    }
}
var person1 = Person1(name: "Lily", age: 10)
person1.info()


/*3.类和结构体的选择*/
/*
    1.结构体的主要目的是用于封装少量相关简单数据
    2.如果需要在传递参数或者赋值时自动复制副本，使用结构体
    3.明确该类型无需继承另外一个已有的类或被其他类继承，使用结构体
    大部分时候，程序应该自定义类而不是自定义结构体
*/

/*
    总结
    1.枚举、类、结构体的定义
    2.只有类才支持继承。枚举和结构体都不可以
    3.只有类的实例可以称为对象
*/



//              Swift 面向对象基础（中）

/*
                Swift中的存储属性和计算属性
*/


/*
    存储属性和计算属性
    方法
    下标
*/
/*
    存储属性和计算属性
    关于存储属性和计算属性，首先需要了解
    1.实例存储属性与实例变量
    2.结构体常量与实例属性
    3.如何定义计算属性
    4.setter方法 getter方法
    5.属性观察者
*/

/*
    存储属性
    1.存储属性:存储在类、结构体里的常量或者变量
    2.存储属性 分为:实例存储属性、类型存储属性
        所谓的实例存储属性: 是属于单个的实例，用来保存这个类型的实例状态数据
        而类型存储属性: 则属于类型本身，比如说类，结构体，枚举
        类，结构体，枚举都可以定义类型存储属性，枚举不能定义实例存储属性，类，结构体例外
    3.所有的存储属性必须显示的指定初始值，在定义时或构造器当中指定初始值
    4.可选类型的存储属性可以不指定初始值
*/
/*
    结构体中实例存储属性的规则
    1.程序为所有的实例存储属性指定了初始值，且没有构造器，则系统会提供两个构造器:一个无参数的构造器和
        一个初始化所有实例存储属性的构造器
    2.没有初始值和构造器，系统就会提供一个初始化所有实例存储属性的构造器
    3.有构造器，则程序必须为结构体中的所有存储属性提供初始值
*/

/*****************存储属性*****************/
struct LengthRange {
    var start: Int
    //定义常量存储属性，可以不指定初始值
    let length:Int
}
var len  = LengthRange(start: 9, length: 3)
//通过构造器参数完成实例存储属性的初始化
//符合 结构体中实例存储属性的规则2
print("len的起点为\(len.start),长度为\(len.length)")
len.start = 2
//len.length = 1 //不能修改，因为length属性是let

//结构体常量与实例属性
struct LengthRange2 {
    var start: Int
    var length: Int
}
let len2 = LengthRange2(start: 1, length: 5)
//len2.length = 4 //不能修改，因为实例len2是let

//延迟存储属性:第一次被调用的时候才会被计算初始值的属性，用lazy修饰符
/*
    延迟存储是一种延迟机制，当某个实例持有另一个创建成本比较大的实例的引用的时候，使用延迟存储可以
    提高程序的性能，延迟存储属性只能被定义成变量，因为常量存储属性在初始化阶段就就会获得初始值了，
    而延迟存储属性是第一次被调用的时候才会被计算初始值的属性，所以常量存储属性就不能使用延迟存储机制
*/


/*
    计算属性
    相当于oc,java等语言当中的通过setter 和 getter 方法合成的属性 @property，
    枚举，结构体，类都可以定义计算属性，其实 计算属性的本质就是getter、setter的
    组合，而至于getter、setter方法具体执行那些代码，完全由程序员决定
*/

/*
    计算属性
    [修饰符] var 计算属性名:属性类型{
        get {
            //get 方法执行体，该方法一定要有返回值
        }
        set(形参名){
            //setter方法执行体，该方法一定不能有返回值
        }
        //get和set的语法格式和oc中是一样的
    }
    [修饰符]可以省略的
*/









/*
    属性观察者:观察属性变化的
    为了能让程序在属性被赋值的时候获得到执行代码的机会，属性观察者可以监听:
    1.除了延迟存储属性之外的所有存储属性(包括实例存储属性和类型存储属性),即便是所赋的值与原来的值相等，
        属性观察者也能监听到
    2.可以通过重载方式为继承得到的属性(包括存储属性和计算属性)添加属性观察者

    ***其实属性观察者就是两个特殊的回调方法
    
    格式:
    [修饰符] var 计算属性名:属性类型 = 初始值 {
        //第一个方法就是
        willSet(newValue) {
            //属性即将被赋值之前自动调用的方法
            //被观察的属性即将被调用之前被调用的方法
        }
        //第二个方法就是
        didSet(oldValue) {
        //属性即将被赋值之后自动调用的方法
        
        }
    }
    注：willSet和didSet后面的参数都可以省略
*/

/**************计算属性***************/
class Users {
    //定义了俩个存储属性，必须指定初始值
    var first:String = ""
    var last:String = ""
    //定义计算属性
    var fullName:String {
        //定义计算属性的getter方法，该方法的返回值由first和last两个存储属性决定
        get{
            return first + "-" + last
        }
        //定义计算属性的setter方法
        //该setter方法将负责改变该实例的first、last两个存储属性
        set(newValue) {
            var names = newValue.componentsSeparatedByString("-")
            self.first = names[0]
            self.last = names[1]
        }
    }
    
    init(first:String, last:String) {
        self.first = first
        self.last = last
    }
}

let s = Users(first: "极客", last: "hello")
print(s.fullName)//得到值调用的是get方法
s.fullName = "极客-学院"//重新赋值调用的是set方法
print(s.first)
print(s.last)//输出重新赋值之后的内容

/*
    只读属性，既然是只读属性，就不需要重新赋值，就可以省略set方法，
    那么就只有get，get和花括号也可以省略

*/


/**************属性观察者***************/

/*
    willSet(newValue):被观察的属性即将被赋值之前自动调用的方法
    didSet(oldValue):被观察的属性被赋值完成之后自动的调用的方法
*/

class Persons {
    //定义存储属性name
//    var name: String = "" {
        
//        willSet {
//            if (countElements(newValue) > 6) || (countElements(newValue) < 2) {
//                print("您设置的人名\(newValue)不符合要求，请重新设置！")
//            } else {
//                print("人名设置符合要求，设置成功")
//            }
//        }
//        
//        didSet {
//            print("人名设置成功，被修改的原名为:\(oldValue)")
//        }
//    }
    //定义存储属性age
    var age: Int = 0 {
        
        willSet {
            //
            if newValue > 100 || newValue < 0 {
                print("您设置的年龄\(newValue)不符合要求，请重新设置！")
            } else {
                print("年龄设置符合要求，设置成功")
            }
        }
        
        didSet {
            print("年龄设置成功，被修改的年龄为:\(oldValue)")
        }
    }
}
var p_ = Persons()
//p_.age = 999
//成功设置age属性后
p_.age = 10
print("成功设置之后，年龄为：\(p_.age)")



/*
                    Swift中的方法
*/


/*
    方法是面向对象的重要组成部分，不过从功能上看，他完全类似于函数
    方法和函数的语法格式是非常相似的
*/

/*
    1.方法的所属性
    2.将方法转化为函数
    3.方法的外部形参名
    4.值类型的可变性
    5.属性和方法的统一
*/

/*
    方法的所属性
    1.定义方法需要在类型(枚举、结构体、类)里定义。不能独立定义，独立定义的话是函数
    2.方法要么属于该类型本身，要么是该类型的一个实例，也就是说要么是类型方法，要么是实例方法
    3.不能独立执行方法，执行方法必须使用类型或实例作为调用者
        其实这与oc当中是一样的，如果是类型方法，那就要用类型去调用，
                            如果是实例方法，那么就要创建这个类型的实例，然后通过实例去调用
    注意:枚举、结构体中的方法用static修饰，类中用class修饰，都属于类型方法，否则的话属于实例方法


*/


/***************************1.将方法转换成函数*******************/
class someClass {
    func test() {
        print("=== test 方法 ===")
    }
    class func bar(msg msg:String) {
        print(" ==bar类型方法，传入的参数为:\(msg)")
    }
}
//创建实例
var sc = someClass()
//将sc的test方法分离成函数
var f1:() -> () = sc.test
//将sc的bar方法分离成函数
var f2:(String) -> Void = someClass.bar
//调用
f1() //等价于sc.test()
f2("极客")//等价于someClass.bar(msg:"Geek")



/***************************2.方法的外部形参名*******************/
class Person2 {
    var name: String
    //构造器方法，进行初始化
    init(name:String) {
        self.name = name
    }
    //
    func eat(food:String, _ drink: String, cigaretter: String) {
        print("\(self.name)吃着\(food),喝着\(drink),抽着\(cigaretter)")
    }
}
//func eat(food:String, drink: String, cigaretter: String) {
//    print("\(self.name)吃着\(food),喝着\(drink),抽着\(cigaretter)")
//}
//eat(<#T##food: String##String#>, drink: <#T##String#>, cigaretter: <#T##String#>)
//创建实例，并在创建实例的时候进行赋值
var p2_ = Person2(name: "Tom")
//这就是Swift中方法的外部参数，新版中和函数的外部参数名规则好像是一样的，
p2_.eat("烤鸭", "啤酒", cigaretter: "雪茄")
/*
    Swift默认为除第一个参数外都添加了外部参数名，与局部参数名一样，如果不需要的话,
    则用 _ 下划线的方式去掉
*/


/***************************3.值类型的可变方法**********************/

/*  
    //调用mutating方法，该方法可以改变实例的存储属性

    既然是值类型，那就是枚举和结构体，而class类是引用类型
    将mutating关键字放在func之前，即将该方法声明为可变方法
*/
struct JKRect {
    var x:Int
    var y:Int
    var width:Int
    var height:Int
    mutating func moveByX(x:Int, y:Int) {
        self.x += x
        self.y += y
    }
}
//创建实例，结构体的实例就只能称为实例，而不能称为对象
var rect = JKRect(x: 20, y: 12, width: 200, height: 300)
//调用mutating方法，该方法可以改变rect实例的存储属性
rect.moveByX(100, y: 90)
print("rect矩形的左上角的x坐标为\(rect.x), y坐标为:\(rect.y)")
/*注意：常量类型的结构体、枚举是不可变的*/



/*
                        Swift中的方法和下标
*/

/*
    属性和方法的统一
    即属性可以成为方法，而方法也可以理解为一种属性
*/

/*
    1.使用函数类型定义存储属性，并将函数或者闭包作为该属性的初始值，这个属性就成了方法。
        函数类型、闭包之前讲过。换个角度看，方法就相当于以let来声明的，类型为函数类型
        的存储属性，如果程序使用var来声明存储属性，并将函数或闭包作为这个属性的初始值，
        这样也可以定义方法，而且这个方法也更加的灵活
*/

/***************************4.属性和方法的统一*******************/

func factorial(n: Int) -> Int {
    var result = 1
    for i in 1...n {
        result *= i
    }
    return result
}
struct SomeStruct {
    //使用闭包作为info函数初始值
    var info: () -> Void = {
        print("info方法")
    }
    //将全局函数作为fact存储属性的初始值
    static var fact: (Int) -> Int = factorial
}
var sc1 = SomeStruct()
//调用info方法
sc1.info()
//使用闭包对sc1对象的info赋值，相当于重新定义sc1的info方法
sc1.info = {
    print("另外一个闭包")
}
sc1.info()

var n = 6
//fact方法，执行的是阶乘
print("\(n)的阶乘是：\(SomeStruct.fact(n))")
//使用闭包调用SomeStruct的fact方法，相当于重新定义SomeStruct的fact方法
SomeStruct.fact = {
    var result = 1
    for i in 1...$0 {
        result += i
    }
    return result
}
//再次调用fact方法，执行的累加
print("\(n)的累加是:\(SomeStruct.fact(n))")


/*      下标
    2.下标的重载
    1.下标的基本用法
*/
/*
    1.所有的Swift类型(枚举、类和结构体)都支持定义下标
    2.同一个类型可以定义多个下标
    3.通过下标的形参列表或返回值类型来区分不同的下标
    4.同一类型中定义多个不同的下标被称为下标重载
*/
/*
    下标的基本用法
    Subscripe(形参列表) -> 下标返回值类型{
        get{
            //getter方法执行体，必须有返回值
        }
        set(形参名) {
            //setter方法执行体，不能有返回值
        }
    }
*/

/*
    下标语法格式说明
    1.形参列表：与函数的形参列表的用法基本相同，但是不支持指定外部参数和默认值
    2.下标的返回值类型：可以是任何有效的类型，常用的整形、浮点型、函数类型都是可以的
*/

/***************************5.下标*******************/
struct JKRect2 {
    var x:Int
    var y:Int
    var width:Int
    var height:Int
    //定义下标，指定下标只接受一个int类型的参数，下标的返回值类型为int
    subscript(index:Int) -> Int {
        //get部分
        get{
            switch index {
            case 0:
                return self.x
            case 1:
                return self.y
            case 2:
                return self.width
            case 3:
                return self.height
            default:
                print("不支持该索引类型")
                return 0
            }
        }
        //set部分
        set {
            switch index {
            case 0:
                self.x = newValue
            case 1:
                self.y = newValue
            case 2:
                self.width = newValue
            case 3:
                self.height = newValue
            default:
                print("不支持该索引类型")
            }
        }
    }
}
//创建实例
var rect2 = JKRect2(x: 20, y: 22, width: 200, height: 300)
//通过下标进行赋值,调用set方法
rect2[0] = 40
rect2[1] = 61
//rect2[0] = 42
//rect2[0] = 43
//通过下标访问rect的属性,调用get方法
print("rect举行的左上角的x坐标为：\(rect2[0]), y坐标为：\(rect2[1])")
/*
    下标也可以定义只读下标，定义只读下标后，set和get的{}都是可以省略的

    下标重载：根据参数的不同或者返回值类型的不同，来区分不同的下标，
    在这个结构体中依然可以定义一个下标，只要参数类型或者返回值类型不同就可以了

*/




//              Swift 面向对象基础（下）

/*  Swift 面向对象基础（下）之    可选链、构造器、类型属性、类型方法

*/

/*
        可选链
    1.可选类型
    2.可选类型就是在原有类型后面添加？，需要强制解析
    3.可选类型在原有类型后面添加！，不需要强制解析，就是默认的隐士解析

    关于可选链
    1.可选链用于处理可选类型的属性、方法、下标
    2.使用可选链代替强制解析   
    3.调用方法
    4.调用下标
*/
//创建三个关联类
class Customer {
    var name = ""
    var emp:Employee?
    init(name:String) {
        self.name = name
    }
}

class Company {
    var name = ""
    var addr = ""
    init(name:String, addr:String) {
        self.name = name;
        self.addr = addr
    }
}

class Employee {
    var name = "Lily"
    var title = "行政"
    var company: Company!
    init (name:String, title: String) {
        self.name = name
        self.title = title
    }
    func info () {
        print("本员工名为\(self.name),职位是\(self.title)")
    }
}
//var c = Customer(name: "Damon")
//var emp = Employee(name: "Elena", title: "Student")
////设置Customer关联的Employee实例
//c.emp = emp
////设置Employee关联的Customer实例
//emp.company = Company(name: "极客学院", addr: "北京市")
//print("为\(c.name)服务的公司是:\(c.emp!.company.name)")
    //使用可选链访问属性  不管是添加？还是！的可选类型，全部使用？
//print("为\(c.name)服务的公司是:\(c.emp?.company?.name)")

//第二种情况
//var c2 = Customer(name: "Wamon")
////var emp = Employee(name: "Elena", title: "Student")
////设置Customer关联的Employee实例
//c2.emp = Employee(name: "Snow", title: "客服")
//////设置Employee关联的Customer实例
////c2.emp!.company = Company(name: "航空学院", addr: "郑州市")
////print("为\(c2.name)服务的公司是:\(c2.emp!.company.name)")    //会崩
//
////使用可选链访问属性，使用可选链的好处，程序会自动判断程序访问的关联实例是否为空值
//print("为\(c2.name)服务的公司是:\(c2.emp?.company?.name)")

//第三种情况
var c3 = Customer(name: "Paul")
//print("为\(c3.name)服务的公司是:\(c3.emp!.company.name)")
//使用可选链访问属性
print("为\(c3.name)服务的公司是:\(c3.emp?.company?.name)")

/*
    1.可选链的访问方式：将强制解析的！换成？，在隐式解析的后面也添加？后缀
    2.可选链会自动判断程序访问的关联实例是否为nil
*/


//剩下的在课件006代码中




































































































































































