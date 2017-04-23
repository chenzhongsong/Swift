//
//  main.swift
//  AttAndClass
//
//  Created by CarolWang on 15/4/14.
//  Copyright (c) 2015年 com.jikexueyuan. All rights reserved.
//

import Foundation

/*
                Swift 面向对象基础（下）

              Swift 中的类型属性和类型方法
*/
/*
    1.Swift的类型(枚举、结构体、类)中可以定义5中成员：属性、方法、下标、构造器和嵌套类型
    2.属性：类型属性、实例属性
    3.方法：类型方法、实例属性
实例属性/实例属性在前面接触的比较多
    4.static：在枚举、结构体中修饰的属性、方法称为类型属性、类型方法
    5.class：在类中修饰的属性、方法称为类型属性、类型方法

    关于Swift 中的类型属性和类型方法只需要记住他们的关键字，值类型的通过static修饰，类通过class修饰
*/

//1.值类型的类型属性
enum Season
    {
    // 为枚举定义类型存储属性，使用可选类型，系统将其初始化为nil
    static var desc : String?
    // 为枚举定义类型存储属性，且声明为常量
    static let name = "季节"
    static var info: String{
    get{
        return "代表季节的枚举，其desc为:\(desc)"
    }
    set{
        print("程序尝试对info计算属性进行赋值:\(newValue)")
    }
    }
}
// 对Season枚举的类型属性赋值
Season.desc = "季节类"
print(Season.name)
Season.info = "新的info"
print(Season.info)
/*结构体可以包含实例计算属性，不能包含实例存储属性*/
    
struct FkRange
        {
        // 为结构体定义类型存储属性，使用可选类型，系统将其初始化为nil
        static var desc : String?
        // 为结构体定义类型存储属性，且声明为常量
        static let maxWidth = 10000
        static let maxHeight = 40000
        // 定义类型计算属性，该属性只有get部分，是一个只读属性
        static var maxArea: Int{
        return maxWidth * maxHeight
        }
}
FkRange.desc = "描述范围的结构体"
print(FkRange.desc)
print(FkRange.maxWidth)
print(FkRange.maxHeight)
print(FkRange.maxArea)
// 2.类的类型属性
class User
        {
        // 为类定义类型计算属性
        class var nameMaxLength : Int{
        get {
        return 24
        }
        set {
        print("程序尝试对User类的nameMaxLength类型计算属性赋值：\(newValue)")
        }
        }
}
print(User.nameMaxLength)
User.nameMaxLength = 20

/*类中不可以定义类型存储属性，只能包含类型计算属性*/
 
  
    //3.  值类型的类型方法

enum Season2
        {
        // 为枚举定义类型存储属性，使用可选类型，系统将其初始化为nil
        static var desc : String?
        // 为枚举定义类型存储属性，且声明为常量
        static let name = "季节"
        // 定义无参数的类型方法
        static func info()
    {
        print("季节类的info方法，该类的name存储属性为：\(name)")
        }
        // 定义带一个参数的类型方法
        static func setDesc(desc : String)
    {
        self.desc = desc  // ①
        }	
}
Season2.info()
Season2.setDesc("描述季节变化的枚举")
print(Season2.desc)
//4.  类的类型方法
class Math
    {
    // 类不允许定义类型存储属性，使用类型计算属性代替
    class var pi: Double{
    return 3.1415926535897932384626
    }
    class func abs(value : Double) -> Double
{
    return value < 0 ? -value : value
    }
    // 定义类型方法，取消第二个形参的外部形参名
    class func pow(base: Double , _ exponent: Int) -> Double {
        var result = 1.0
        for idx in 1...exponent
        {
            result *= base
        }
        return result
    }
    // 定义类型方法，类型方法可直接访问类型属性
    class func radian2Degree(radian:Double) -> Double
{
    return radian * 180 / pi
    }
    // 定义类型方法，类型方法可通过self引用类型属性
    class func degree2Radian(degree:Double) -> Double
{
    return degree * self.pi / 180
    }
}
print(Math.pi)
print(Math.pow(2 , 4))
print(Math.radian2Degree(1.57))
print(Math.degree2Radian(45))

