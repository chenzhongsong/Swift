//
//  main.swift
//  Swift-中的协议和扩展
//
//  Created by chenzs on 16/3/17.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation

/*
        1.Swift 中的扩展添加属性和方法
*/

/*
        Swift基础面向对象高级--扩展
*/

/*
    1.使用扩展添加属性--包括类型属性、实例计算属性
    2.使用扩展添加方法、可变方法--实例方法、类型方法
    3.使用扩展添加构造器--新的构造器并不影响原有的构造器，还有使一个已有类型符合一个或多个协议
    4.使用扩展添加下标
    5.使用扩展添加嵌套类型
*/

/*  扩展的作用：
    1.使用扩展添加属性、方法、可变方法、构造器、下标、嵌套类型
    2.可以使一个已有类型符合一个或者多个协议
    3.Swift的扩展与oc的类目（category）类似，只是Swift中的扩展没有名字
    4.扩展并不是派生子类，因此不支持重写
*/

/*
    扩展的语法定义

    [修饰符] extension 已有类型 {
        //添加新功能
    }
    [修饰符]可以省略，或者是private、internal、public其中之一，类型可以是枚举、结构体和类其中之一
    注意：通过扩展为已有类型添加新功能，那这个新功能在该类型的所有已有实例中都是可用的
*/

/*
    通过扩展让已有的类型遵守一个或者多个协议
    这种情况的语法格式：
    [修饰符] extension 已有类型：协议1，协议2 {
        添加新功能
    }
*/

/*
    使用扩展添加属性、方法
    1.使用扩展可以添加3种属性：不能添加实例存储属性
        1》类型存储属性
        2》实例计算属性
        3》类型计算属性
    2.使用扩展可以添加实例方法或者类型方法
*/

//使用扩展来添加属性，通过扩展来增加String的功能
/*
extension String {
    //通过扩展来添加了一个类型存储属性
    static var data:[String:Any] = [:]
    //实例计算属性
    var length:Int {
        get {
            return count(self)
        }
        set {
            var originLength = count(self)
            //如果新设置的长度大于字符串原有长度，在字符串后面添加空字符
            if newValue > originLength {
                for idx in 1...newValue - originLength {
                    self += " "
                }
            } //如果新设置的长度小于字符串原有长度，将后面多余字符串截断
            else if newValue < originLength
            {
                var tmp = ""
                var count = 0
                for ch in self {
                    tmp = "\(tmp)\(ch)"
                    count++
                    //如果已经拼接了newValue个字符，跳出循环
                    if count == newValue {
                        break
                    }
                }
                self = tmp
            }
        }
    }
}
String.data["swift"] = 89
String.data["OC"] = 92
print(String.data)
var s = "jike.org"
//通过length长度输出字符串长度
print(s.length)
//通过设置length属性，截断String后面多出来的字符
s.length = 5
print(s)
//通过设置length属性，在String后面补充空格
s.length = 10
print(s)
*/

/*
    通过上面的代码演示了添加实例计算属性，添加类型计算属性与添加实例计算属性的方式基本一样
    只是在属性前面加上static 或 class修饰符
*/


//下面是通过扩展来添加方法
/*
    扩展可以添加类型方法，也可以添加实例方法,添加类型方法就是在实例方法前面添加static或class

*/
/*
extension String {
    //添加一个新方法，用于获取当前字符串中指定范围的子串，这是一个是你方法
    func substringFromStart(start: Int, toEnd: Int) -> String {
        var count = 0
        var tmp = ""
        for ch in self {
            if count >= start {
                tmp = "\(tmp)\(ch)"
            }
            if count >= toEnd - 1 {
                break
            }
            count++
        }
        return tmp
    }
    //定义一个类方法,将bool类型转换为字符串类型
    static func valueOf (value:Bool) -> String {
        return "\(value)"
    }
}
var str = "jike.isagoodstudycenter"
//截取原字符串中从索引5开始，到索引10之间的子串
var subStr = str.substringFromStart(5, toEnd: 10)
print(subStr)
print(String.valueOf(true))
print(String.valueOf(false))
*/
/*
    这个程序比较简单，没有考虑start参数为负数的情况，也没有考虑toEnd参数过大的情况
*/














/*
        2.Swift 中的扩展添加下标和构造器
*/
/*
    1.使用扩展添加可变方法
    2.构造器
    3.类型
    4.嵌套类型

    上一个课时讲了通过扩展添加方法，这里是使用扩展添加可变方法
    可变方法可以改变值类型的实例本身，注意：类不可以定义可变方法，所以也就不能使用扩展来为类
        添加可变方法
*/
extension Array {
    //定义一个方法，用于计算数组的交集  mutating修饰可变方法   Element <- T
    mutating func retainAll(array:[Element], compartor:(Element, Element) -> Bool) {
        var tmp = [Element]()
        //遍历当前数组中所有元素
        for ele in self {
            //遍历第二个数组中的所有元素
            for target in array {
                //如果两个元素通过compartor比较返回true
                if compartor(ele, target) {
                    tmp.append(ele)
                    break
                }
            }
        }
        self = tmp
    }
}
var books = ["iOS", "Android", "Swift", "Java", "Ruby"]
//books.retainAll(["Android", "iOS"], compartor: <#T##(String, String) -> Bool#>)
books.retainAll(["Android", "iOS"]){
    return $0 == $1
}
print(books)
/*
    通过扩展添加可变方法，最重要的就是扩展的关键词extension和可变方法的关键词mutating
*/

/*
    通过扩展添加的构造器并不会影响系统原有的构造器
*/
// 定义一个结构体
struct SomeStruct {
    var name:String
    var count: Int
}
//使用扩展来添加构造器
extension SomeStruct {
    init (name:String) {
        self.name = name
        self.count = 0
    }
    init(count:Int) {
        self.count = count
        self.name = ""
    }
    
}
//下面使用了SomeStruct的3个构造器
var sc1 = SomeStruct(name: "jike", count: 5)//系统的
var sc2 = SomeStruct(name: "crazyjike")
var sc3 = SomeStruct(count: 20)

/*
    通过扩展给已有的类型添加下标的方法，与前面介绍的添加属性、方法、可变方法、构造器
    并没有太多的区别，同样就是将下标定义放在扩展的花括号里面就可以了
*/
/*
extension String {
    subscript(idx: Int) -> String {
        get {
            //如果下标位于字符串长度之内
            if idx > -1 && idx < countElements(self) {
                var count = 0
                var result = ""
                //通过遍历搜索字符串内指定索引处的字符
                for ch in self {
                    if count == idx {
                        //将找到的字符转换为字符串
                        result = "\(ch)"
                    }
                    count++
                    
                }
                return result
            } else {
                return ""
            }
            
        }
        set {
            var result = ""
            var count = 0
            for ch in self {
                if count == idx {
                    result += newValue
                } else {
                    result += "\(ch)"
                }
                count++
            }
            self = result
        }
    }
    
    //定义只读下标  只有get部分  get可以省略
    subscript(start: Int , end: Int) -> String {
        //如果start、end都位于字符串长度之内，且start小于end
        if start > -1 && start < countElements(self)
                      && end > -1 && end <= countElements(self)
                      && start < end  {
                        var result = ""
                        var count = 0
                        for ch in self {
                            if count >= start && count < end {
                                result.append(ch)
                            }
                            count++
                        }
                        return result
        } else {
            return ""
        }
    }
}
//定义一个字符串
var s = "jike is a excellent training center"
//通过下标访问索引为5的字符
print(s[5])
//通过下标改变字符串指定索引处的字符
s[0] = "J"
s[2] = "K"
print(s)
//通过带两个Int参数的下标来获取字符串中间范围的子串
print(s[2, 0])
*/

//通过扩展来添加嵌套类型
/*
    通过扩展给已有的类型添加嵌套类型，就像前面介绍的定义嵌套类型一样，
    只要程序把嵌套类型放在扩展的花括号内定义就可以了
*/
extension String {
    //定义一个嵌套枚举
    enum Suit : String {
        case Diamond = "♦️"
        case Club = "♣️"
        case Heart = "❤️"
        case Spade = "🐔"
    }
    // 通过扩展为String增加一个类型方法，用于判断指定字符串属于哪种花色
    static func judgeSuit(s: String) -> Suit? {
        switch s {
            case "♦️":
            return .Diamond
            case  "♣️":
            return .Club
            case "❤️":
            return .Heart
            case "🐔":
            return .Spade
        default:
            return nil
        }
    }
}
//使用String包含的嵌套枚举
var s1: String.Suit? = String.judgeSuit("❤️")
print(s1)
var s2: String.Suit? = String.judgeSuit("j")
print(s2)
















/*
           3. Swift 中的协议
*/

//其实，只要掌握了前面的基础知识，如：属性、方法、下标 它们的定义，对于扩展，其实是很简单的

// Swift当中的协议，完全类似于oc中的协议，是用来定义多个类型应该遵守的规范
/*
    协议
    1.Swift协议用于定义多个类型应该遵守的规范
    2.协议定义了一种规范，不提供任何实现。
        //类是一种具体的实现体，而协议定义了一种规范，它定义某一批类所遵守的规范，
        但是协议不关心这些类的内部状态数据，也不关系这些类里方法的实现细节，
        它只规定这批类里必须提供某些方法，所以它不提供任何实现，协议提现的就是规范和实现
        分离的设计哲学，让规范和协议分离，这是协议的好处，是一种松耦合的设计
    3.协议统一了属性名、方法、下标，但是协议不提供任何实现
    4.协议的语法格式：
        [修饰符] protocol 协议名：父协议1，父协议2，...{  //可以继承多个父协议
                    // 协议内容

            }

        实现协议的枚举、结构体、类，都称为协议的实现者，协议的实现者就必须提供协议
        所要求的属性、方法、构造器、下标等
*/

/*
    协议语法说明
    1.修饰符：可以省略，也可以是private、internal、public之一（在隐藏和封装中会讲到）
    2.协议名应该与类名采用相同的命名规则
    3.一个协议可以有多个直接父协议，但协议只能继承协议，不能继承类
    4.协议内容：指定协议实现者必须提供的那些功能，比如属性、方法、构造器和下标等
        //在协议中定义了属性，那相对应的实现体，如枚举、结构体、类就要提供相对应的属性
            
    这是定义协议的语法
*/

/*
    实现协议的语法

    1.Struct结构体名：第一个协议，第二个协议，... {//后面是它所要遵守的协议，它可能遵守多个协议，多个协议之间就用逗号进行隔开
            //实现协议要求，属性、方法、下标等
    }
    枚举实现协议的语法与上面结构体实现协议的语法一样

    2.Class类名：SuperClass，第一个协议，第二个协议，...{//类不仅可以实现多个协议，还可在实现协议时继承一个父类，父类的位置注意，放在所有协议之前，SuperClass是父类的名称
            //实现协议要求
    }

    这是定义与实现协议的语法。我们学习扩展也是通过属性、方法、下标来了解扩展的，协议也是按照这样的一个步骤来具体了解一下协议的知识
*/
/*
    协议指定的属性要求：
    协议可以要求实现者必须提供包含特定名称的实例属性或类型属性，也能够要求这个属性是否有set部分或get部分，
    但是至于这个属性是存储属性还是计算属性，协议并不关心

    1.协议中定义属性要求的语法格式：
        class var 属性名:类型{get set}  //只要掌握属性的定义，这个没有难度，用class来修饰的表示是一个类型属性
    说明：class：可有可无。有说明是类型属性，否则是实例属性
        注意：不可以使用static代替class
        get和set部分：只需要写get、set即可，无须提供实现。set可有可无。如果有set就表示读写属性。如果没有，就要求实现者只需提供与之相对应的只读属性，如果也提供了set也是可以的。总之：协议要求的就是必须实现的，至于协议之外的协议并不关心
*/
//工程中看一下 协议指定的属性要求
protocol Strokable {
    var strokeWidth:Double {get set}
}
protocol Fullable {
    var fullColor: Color? {get set}
}
//定义一个枚举作为协议属性的类型,协议并不支持嵌套，所以这个枚举定义在外边
enum Color {
    case Red, Green, Blue, Yellow, Cyan
}
protocol HasArea:Fullable, Strokable {//协议是多继承的，弥补了类单继承的不足
    var area:Double {get}
}
protocol Mathable {
    class var pi: Double {get}
    class var e: Double {get}
}
//让Rect实现2个协议
struct Rect: HasArea, Mathable {
    var width: Double
    var height:Double
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    //使用存储属性实现Fullable协议的fullColor属性
    var fullColor: Color?
    //使用存储属性实现Strokable协议的strokeWidth属性
    var strokeWidth: Double = 0.0
    //使用存储属性实现HashArea协议要求的area属性,从这里可以看出不管协议中如何定义属性要求，那实现类既可以采用存储属性来实现协议要求的属性，也可以采用计算属性来实现协议要求的属性
    var area: Double {
        get {
            return width * height
        }
    }
    //通过存储属性实现Mathable协议要求的两个类型属性
    //虽然协议中使用class关键字定义类型属性，但是值类型(结构体和枚举)中依然使用static定义类型属性
    static var pi:Double = 3.1415926
    static var e:Double = 2.71826
    //使用类来实现协议与使用结构体、枚举实现协议基本相似，只是使用类来实现协议的类型存储属性的时候，使用的就是class关键字，而不是static，这一点与之前所讲类型存储属性的时候是一样的。值类型中用static进行修饰的，类当中是通过class来进行修饰的
    
    
    //协议中指定构造器、方法、下标的要求在下面讲解
}
















































