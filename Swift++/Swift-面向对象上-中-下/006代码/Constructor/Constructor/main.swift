//
//  main.swift
//  Constructor
//
//  Created by CarolWang on 15/4/15.
//  Copyright (c) 2015年 com.jikexueyuan. All rights reserved.
//

import Foundation

/*
                Swift 面向对象基础（下）

                    Swift 中的构造器
*/

/*
    构造器主要用来完成实例的构造过程，也就是用来为实例中的每个存储属性设置初始值和执行初始化
    与oc构造器不同的是。Swift构造器不需要显示声明返回值类型，也就不需要使用return返回实例
    1.Swift的构造器构造出来的实例由系统隐式返回
    2.构造器的作用完成每个类、结构体中实例存储属性的初始化
    3.为实例存储属性赋初始值的时机
        1》定义实例存储属性时指定初始值
        2》在构造器中为实例存储属性指定初始值
*/

/*
    实例存储属性的初始化分类
    1、定义实例存储属性时显示指定了初始值
    2、实例存储属性的类型为可选类型
    3、系统提供的默认构造器为实例存储属性分配初始值
    4、显示提供的构造器为实例存储属性分配初始值
    其实这几类就是：要么在定义的时候显示指定初始值，要么在构造器中定义初始值
*/

/*
    类和结构体的构造器
    1、Swift只为类提供一个无参数的构造器
    2、Swift为结构体提供两个构造器：无参数的构造器和初始化所有实例存储属性的构造器

    也就是说，如果在类中有需要在构造器中指定初始值的实例存储属性，那必须由程序员来进行自定义，
    且完成赋值，系统就不会为这个类来提供任何的构造器，同理的为结构体中的构造器也是这样的，
    总体来说就简单的一句话---需要自定义的，就自己定义构造器，不需要自定义的，那系统就会默认的根据
    需要来提供构造器

*/

/*
    有时候枚举、结构体、类的构造器可能不能返回这个类的实例，比如说用户传入的参数无效，那么就有可能返回可能失败的构造器
    1、可能失败的构造器：使用init？或者init！关键字进行定义
    2、在构造器执行体中使用return nil 来表示构造器失败
    3、Swift不允许定义两个相同形参列表的构造器，即使一个可能失败的构造器，一个是普通的构造器也不行
*/

/*构造器的外部形参名*/
struct FkPoint
    {
    var left: Int = 0
    var top: Int = 0
    //定义带两个参数的构造器，并为第二个构造器参数显式指定外部形参名
    init(left: Int , y top: Int)
{
    self.left = left
    self.top = top
    }
}
// 第一个形参的外部形参名与局部形参名相同
// 第二个形参的外部形参名使用显式指定的形参名
var p1 = FkPoint(left:20 , y:12)



/*取消构造器的外部形参名*/
class Person
    {
    var name: String?
    var gender: String?
    var age = 0
    // 由于该类中前2个实例存储属性使用了可选类型，后1个实例存储属性指定了初始值，
    // 因此该结构体对构造器没有要求，故此处可随便定义一个带参数的构造器
    // 取消构造器参数的外部形参名
    init(_ name:String , _ gender:String)
{
    self.name = name
    self.gender = gender
    }
}
// 调用构造器时无需使用外部形参名
var p = Person("孙悟空" , "男")
print(p.name)
print(p.gender)
print(p.age)





/*在构造过程中常量属性是可以修改的*/
//class User
//    {
//    let maxAge = 100
//    var name: String
//    init(maxAge: Int , name :String) {
//      print(self.maxAge)
//      self.maxAge = Int.max
//      print(self.maxAge)
//      self.name = name
//      self.maxAge = maxAge
//    }
//}
//var u = User(maxAge:120 , name:"白骨精")
//print(u.maxAge)
//print(u.name)




/*使用闭包或函数为属性设置初始值*/
//struct ClosureInit {
//    // 使用闭包对test实例存储属性执行初始化
//    var test: Int = {
//    var dt = NSDate()
//    var gregorian = NSCalendar.currentCalendar()
//    // 定义一个时间字段的旗标，指定将会获取指定月、日信息
//    var unitFlags = NSCalendarUnit.CalendarUnitMonth
//    | NSCalendarUnit.CalendarUnitDay
//    var comp = gregorian.components(unitFlags
//    , fromDate:dt)
//    // 获取当前的月份
//    var month = Int(comp.month)
//    // 获取当前第几日
//    var day = Int(comp.day)
//    // 得到计算结果
//    return day - month
//    }()
//}
//var ci = ClosureInit()
//print(ci.test)








/*值类型的构造器重载*/
//只要形参列表不同就可认为是重载
//struct ConstructorOverload {
//    var name: String!
//    var amount: Int!
//    // 提供无参数的构造器
//    init(){ }
//    // 提供带两个参数的构造器来完成构造过程
//    init(name: String, amount: Int)
//{
//    self.name = name
//    self.amount = amount
//    }
//}
//// 通过无参数构造器创建ConstructorOverload实例
//var oc1 = ConstructorOverload()
//// 通过有参数构造器创建ConstructorOverload实例
//var oc2 = ConstructorOverload(
//    name:"HelloWorld",amount:800000)
//print("\(oc1.name)  \(oc1.amount)")
//print("\(oc2.name)  \(oc2.amount)")












/*构造器代理：在定义构造器时，通过self.init(实参)调用其他构造器来完成实例的部分构造过程，
    即在一个构造器当中调用另一个构造器方法*/
//struct Apple
//    {
//    var name: String
//    var color: String
//    var weight: Double!
//    init(_ name: String , _ color:String)
//{
//    self.name = name
//    self.color = color
//    }
//// 两个参数的构造器
//    init(name: String , color:String)
//{
//    self.init(name , color)  // 构造器代理
//    }
//// 为构造器显式指定外部形参名
//    init(appleName n: String , appleColor c:String)
//{
//    //		name = "临时值" // 这行代码将导致错误
//    self.init(n , c)  // 构造器代理
//    // 调用构造器代理之后，即可通过self访问该实例的属性
//    print("--执行显式指定外部形参名的构造器--\(self.name)")
//    }
//// 定义三个参数的构造器
//    init(name: String , color: String , weight: Double)
//{
//    self.init(name , color)  // 构造器代理
//    self.weight = weight
//    }
//}
//var ap1 = Apple("红富士" , "粉红色")
//print("\(ap1.name)--->\(ap1.color)")
//var ap2 = Apple(appleName:"青苹果" , appleColor:"绿色")
//print("\(ap2.name)--->\(ap2.color)")
//var ap3 = Apple(name:"美国苹果" , color:"红色" , weight:0.45)
//
//




/*可能失败的构造器*/

struct Cat
        {
        let name: String
        init?(name: String) {
        // 如果传入的name参数为空字符串，构造器失败，返回nil
        if name.isEmpty {
        return nil
        }
        self.name = name
        }
}
let c1 = Cat(name: "Kitty")
if c1 != nil {
        // 创建c1的构造器是init?，因此程序必须对c1执行强制解析
        print("c1的name为：\(c1!.name)")
    }
let c2 = Cat(name: "")
print(c2 == nil) // 输出true，表明c2为nil




enum Season{
    case Spring, Summer, Autumn, Winter
    // 使用init!定义可能失败的构造器，则该构造器创建的实例可进行隐式解析
    init!(name: Character) {
        // 根据传入的构造器参数选择相应的枚举成员
        switch name {
        case "S","s":
            self = .Spring
        case "U", "u":
            self = .Summer
        case "A", "a":
            self = .Autumn
        case "W", "w":
            self = .Winter
            // 如果传入其他参数，构造失败，返回nil。
        default:
            return nil
        }
    }
}
let s1 = Season(name: "s")
if s1 != nil {
    print("Season实例构造成功！")
}
let s2 = Season(name: "x")
print(s2 == nil)

/*
1.Swift只为类提供一个无参数的构造器。
2.Swift为结构体提供两个构造器：无参数的构造器和初始化所有实例存储属性的构造器。

*/














