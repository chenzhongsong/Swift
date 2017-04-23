//
//  main.swift
//  Swift中的继承和多态
//
//  Created by chenzhongsong on 16/3/18.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation
/*
/*
                            Swift中的继承和多态
*/

/*    （一）  Swift 中的继承

    Swift面向对象三大特性：继承、封装、多态
*/

/*
    只有类才支持 继承和多态
*/

/*                              Swift 中的继承

    继承特点：
    重写父类的方法
    重写父类的属性
    重写属性观察者
    重写父类下标
    使用final关键字防止重写

    1.单继承，每个子类只有一个 直接 父类，如果不显示指定的父类，那么这儿类就没有父类
        与oc不同的是 它并不继承nsobject，每个子类只有一个直接父类，但可以有多个间接父类
    2.子类继承父类，可以获得父类的属性、方法、下标，也可以对这些进行重写
    3.Swift的类并不是从一个通用的基类继承而来的，即如果不显示指定的父类，那么这儿类就没有父类
    4.override 修饰被重写的部分
    5.final修饰的类不能被继承，继承、方法和下标不能被重写
    Swift中的继承是单继承
*/

/*   继承    */
class Fruit {
    var weight = 0
    func info() {
        print("我是一个水果，重\(weight)g!")
    }
}
class Apple: Fruit {
    var name: String! //不需要进行强制解析的可选类型
    func taste () {
        print("\(name)吃起来很好吃")
    }
}
//创建类实例，只有类才支持继承和多态
var a = Apple()
//Apple本身没有weight属性
//因为Apple的父类有weight属性，也可以访问Apple实例的weight属性
a.weight = 56
a.name = "红富士"
//调用Apple实例的方法，Apple类继承父类的属性和方法
a.info()
a.taste()

/*   重写父类的方法 使用override关键字   */

class Bird {
    //Bird类的fly()方法
    func fly() {
        print("我在天空自由的飞翔。。。")
    }
}
class Ostrich: Bird {
    //重写Bird类的fly()方法
    override func fly() {
        print("我只能在地上奔跑。。。")
    }
}
//创建Ostrich实例
var os = Ostrich()
//执行Ostrich实例的fly()方法
os.fly()


/*   重写父类的下标 使用override关键字   */

class Base {
    subscript (idx: Int) -> Int {
        // 父类只有get方法
        get {
            print("ful下标的get方法")
            return idx + 10
        }
    }
}
class Sub: Base {
    //重写Base类的下标，既可以重写get方法，也可以添加set方法
    override subscript (idx: Int) -> Int {
        get {
            print("重写后的下标的get方法")
            print("通过super访问被重写之前的下标：\(super[idx])")
            return idx * idx
        }
        set {
            print("重写后的下标的set方法，传入的参数值为：\(newValue)")
        }
        
    }
}
var base = Base()
print(base[7])  //17
var sub = Sub()
print(sub[7])   //49
sub[7] = 90

/*   重写父类的属性 使用override关键字   */
class Birds {
    var speed: Double = 0
}
class Ostrichs: Birds {
    //重写Bird类的speed属性
    //子类不知道重写的属性是存储属性还是计算属性，所以在重写的时候一定要写上名称和类型
    //前面提到：只要为计算属性提供set方法，就必须为其提供get方法
    override var speed: Double {
        get {
            print("正在访问被重写的属性")
            return super.speed
        }
        set {
            super.speed = newValue * newValue
        }
    }
}
//创建Ostrichs实例
var oss = Ostrichs()
//对重写后的属性赋值
oss.speed = 20.0
//访问被重写的属性
print("oss的速度为：\(oss.speed)")


/*   重写父类的属性观察者 使用override关键字   */
class Birdss {
    var speed: Double = 0
}
class Ostrichss: Birdss {
    //重写Bird类的speed属性,添加属性观察者
    //子类不知道重写的属性是存储属性还是计算属性，所以在重写的时候一定要写上名称和类型
    
    override var speed: Double {
        didSet {
            //属性被改变完成后，将会自动调用该方法
            print("改变之前的speed为：\(oldValue)")
            super.speed *= speed
        }
        
    }
}
//创建Ostrichs实例
var osss = Ostrichss()
//对重写后的属性赋值
osss.speed = 20.0
//访问被重写的属性
print("osss的速度为：\(osss.speed)")
/*
    注意：不要同时重写父类的属性即添加set和get方法 和 添加属性观察者,因为他们都改变了父类属性，有点重复
        不要给常量存储属性和只读计算属性添加属性观察者，因为这些属性本身就不会发生改变，添加了也没有意义
*/


/*   final防止重写   */
/*
    只要在类前面添加final，里面的final可以省略，里面的属性，方法，下标都不能重写
*/
final class Bases {
    final var name: String = ""
    final func say(content:String) {
        print("Bases实例说：\(content)")
    }
    final subscript(idx: Int) -> Int {
        get{
            print("父类的下标的get方法")
            return idx + 10
        }
    }
}
class Subs: Bases {
    //尝试重写覆盖的name属性
    override var name: String {
        get {
            return "子类添加的前缀" + super.name
        }
        set {
            
        }
    }

    //尝试重写父类的方法
    override func say (content:String) {
        print("重写父类的say方法，说的内容是：\(content)")
    }
    //尝试重写父类的下标
    override subscript(idx: Int) -> Int {
        get{
            print("重写后的下标的get方法")
            print("通过super访问被重写之前的下标：\(super[idx])")
            return idx * idx
        }
        set {
            print("重写后的下标的setter方法，传入的参数值为：\(newValue)")
        }
    }
    
}

*/


/*      （二）  Swift 中的多态

        Swift面向对象三大特性：继承、封装、多态
        1.Swift引用变量有俩个类型：编译时类型、运行时类型 //编译器只认每个变量的编译时类型
        2.编译时类型由声明该变量时使用类型决定
        3.运行时类型由实际赋给该变量的实例决定
            //编译器只认每个变量的编译时类型，如果运行时和编译类型不一致的话，就可能出现所谓的多态
        4.多态：相同类型的变量，调用同一个方法时呈现出多种不同的行为特征
*/

class BaseClass {
    func base() {
        print("父类的普通方法")
    }
    func test() {
        print("父类的被覆盖的方法")
    }
}
class SubClass:BaseClass {
    //重写父类的方法
    override func test() {
        print("子类重写父类的方法")
    }
    func sub() {
        print("子类的普通方法")
    }
}
let bc:BaseClass = BaseClass()
//下面的两次调用将执行BaseClass方法
//在这里，编译时类型和运行时类型是一样的，所以说不存在多态
bc.base()
bc.test()
let sc: SubClass = SubClass()
//下面的方法将执行从父类继承到的base()方法
sc.base()
//下面调用将执行从当前类的test()方法
sc.test()
sc.sub()//不会报错
//因为这两个常量bc和sc，编译时类型和运行时类型是一样的，所以说不存在多态

//下面编译时类型和运行时类型不一样，多态发生,和sc实例运行结果一样
let ploymophicBc:BaseClass = SubClass()
//下面调用将执行从父类继承到的base()方法
ploymophicBc.base()
//下面调用将执行从当前的test()方法
ploymophicBc.test()
//因为ploymophicBc的编译时类型是BaseClass，运行时类型是SubClass
//BaseClass类没有提供sub方法，所以下面的代码编译时会报错
//ploymophicBc.sub()
/*

    在这里把一个子类的实例直接赋给一个父类的引用变量，不需要类型转换，系统会自动默认转换，这称为向上转型

    在这里编译时类型是BaseClass，运行时类型是SubClass，当我们运行的时候，它的方法行为总是表现出子类方法
    的行为特征，而不是父类的方法的行为特征，即：相同类型的变量，调用同一个方法时呈现出多种不同的行为特征，这就是多态

*/



//类型检查和向下转型
/*
    使用is运算符检查类型
    1.使用is运算符检查类型，返回值为布尔类型
        //使用is运算符来判断前面的引用变量是否引用后面的类或子类的实例，是返回true、否返回false
    2.前一个操作数是一个引用变量，后一个操作数是一个类
    3.运算符前面操作数的编译类型要么与后面的类相同，要么具有继承关系，否则编译报错(后面的继承前面的)
    4.检查的是实际类型(运行时类型)的比较
*/

//定义一个可以被oc类使用的协议
@objc protocol TestProtocol {}
//hello的编译类型是NSObject，实际类型(运行时类型)是NSString
let hello: NSObject = "Hello"
//NSString继承NSObject，为true
//print("字符串是否是N SString类的实例:\(hello is NSString)")
//print("字符串是否是N SDate类的实例:\(hello is NSDate)")
//print("字符串是否是TestProtocol协议的实例:\(hello is TestProtocol)")

//N SDate 不继承NSString，会报错，而且他们的类也不相同，是编译错误
//let a:N SString = "Hello"
//print("\(a is NSDate)")

/*
    is运算符的主要作用：在进行强制类型解析之前，首先判断前一个引用变量是否引用后一个类
        或者是他子类的实例是否可以成功转换，可以保证代码的健壮性
*/




/*    （三）  向下转型与嵌套类型


Swift面向对象三大特性：继承、封装、多态
*/
























































