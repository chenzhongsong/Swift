//
//  main.swift
//  Swift中的继承和多态-下
//
//  Created by chenzhongsong on 16/3/18.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation

/*    （三）  向下转型与嵌套类型


Swift面向对象三大特性：继承、封装、多态
*/


/*
    使用as运算符向下转型 以及嵌套类型的概念
    1.向上转型：把一个子类的实例直接赋给一个父类引用变量、不用任何类型转换
        当编写Swift程序的时候，引用变量只能调用它编译时类型的方法，不能调用运行时类型的方法，
        如果需要引用变量调用它运行时类型的方法，那就需要用到强制类型转换，
    2.引用变量只能调用它编译时类型的方法，
        强制转换为实际类型之后，就可以调用运行时类型方法，这种强制转换就为  --- 向下转型
    3.向下转型运算符：有两种形式
        1》as：强制将运算符前面的引用变量转换为后面的类型，新版Swift现在是as!
        2》as？：可选形式的向下转型
    4.向下转换只能在具有继承关系的两个类型之间进行，这与is运算符是类似的

*/
//那些情况可以进行类型转化，哪些情况不能进行类型转化
//声明了一个引用变量obj,编译时类型NSObject，运行时类型NSString
let obj: NSObject = "Hello"
let objStr: NSString = obj as! NSString
print(objStr)
//定义一个objPri变量，编译时类型为NSObject，实际类型为NSNumber
/*  
    objPri的编译时类型是NSObject，str编译时类型是NSString，具有继承关系，编译不报错，
    objPri的运行时类型是NSNumber，str运行时类型是NSString，不具有继承关系，运行奔溃，
*/
//let objPri: NSObject = 5
//let str:NSString = objPri as! NSString
//编译时类型NSString和NSNumber不具有继承关系，编译报错
//let s:NSString = "Swift"
//let it: NSNumber = s as NSNumber
//可以先用is运算符进行类型判断，检查的是实际类型(运行时类型)的比较
//if objPri is NSString { let str: NSString = objPri as! NSString}
//也可以利用可选形式的向下转换，使用as?


//下面是可选类型向下转化的实例程序
class Fruit {
    var name:String
    var weight:Double
    init(name: String, weight:Double) {
        self.name = name
        self.weight = weight
    }
}
class Apple: Fruit {
    var color: String
    init(name: String, weight: Double, color: String) {
        self.color = color
        super.init(name: name, weight: weight)
    }
}
class Grape: Fruit {
    var sugarRate: Double
    init(name:String, weight: Double, sugarRate: Double) {
        self.sugarRate = sugarRate
        super.init(name: name, weight: weight)
    }
}
//定义元素为Any的数组，该数组的元素几乎可以放置任何数据
var anyArray:[Any] = ["Swift",
                        29,
                        ["iOS": 89, "android": 92],
                        Fruit(name: "樱桃", weight: 2.3),
                        Apple(name: "红富士", weight: 2.4, color: "粉红")]

//遍历元素为Any的数组
for element in anyArray {
    //尝试将数组元素强制转为Fruit，然后执行可选绑定
    if let f = element as? Fruit {
        print("\(f.name)水果重\(f.weight)")
    }
}
//定义元素为AnyObject的数组，该数组的元素只能是对象
var anyObjectArray: [AnyObject] = [Fruit(name: "樱桃", weight: 2.3),
                                   Apple(name: "红富士", weight: 2.4, color: "粉红")]

/*
    Any 和 AnyObject
    1.AnyObject：可代表任何类型的实例
    2.Any：可代表任何类型，包括int、double等值类型、AnyObject修饰的实例
        //其实Any是AnyObject的总类
*/



/*
    嵌套类型
    1.在一个类型的内部定义另一个类型
    2.Swift的枚举、类、结构体都可以定义嵌套类型
    3.Swift的嵌套类型支持多级嵌套
    4.嵌套类型不允许使用static或class修饰
*/

class User {
    
    var holidays: [Weekday]
    var location: Point
    init (holidays: [Weekday], location: Point) {
        self.holidays = holidays
        self.location = location
    }
    //定义一个嵌套类型：结构体Point
    struct Point {
        var latitudd:Double
        var longitude: Double
        var position: Orientation
        //嵌套枚举
        enum Orientation {
            case Up, Left, Bottom, Right
        }
    }
    //定义一个嵌套类型：枚举Weekday
    enum Weekday {
        case Moday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
        struct Duration {
            var num: Double
            var unit: String
        }
    }
}
//使用嵌套类型时，需要以被嵌套类型的名字为前缀
var user = User(holidays: [],
                location: User.Point(latitudd: -23.33, longitude: 122.11,
                position: User.Point.Orientation.Left))

//引用User.Weekday嵌套枚举
user.holidays.append(User.Weekday.Saturday)
user.holidays.append(User.Weekday.Sunday)










































