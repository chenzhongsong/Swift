//
//  main.swift
//  Simple
//
//  Created by CarolWang on 14/12/10.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

import Foundation

//print("Hello, World!")
//1.基本数据类型 Int 整型 ， Double 和 Float 浮点型， Bool 布尔值，String 文本型数据
//2.常量 let， 变量 var
let con = 100;
var avi = 30;
avi = 40

//3.一行中声明多个变量或者常量，用逗号隔开
//var a = 3, b = 4, c = 5

//4.类型标注：如果声明的同时赋了初始值，并不需要类型标注
var Who: String
Who = "xiaoming"

//5.变量和常量的命名：不能包含数学符号，箭头，连线与制表符，不能以数字开头
let 你好 = "nihao"
//print(你好)

var 😊 = "笑"
//print(😊)

var 眼睛 = "👀"
//print(眼睛)

//6.字符串插值
var apples = 10
var oranges = 4
//print("I have \(apples + oranges) fruits")

//7.注释 多行注释可以嵌套
/*

/*
第一层注释
第二层注释
*/

*/


let count = 3_000_000_000_000
let countedThings = "stars in the Milky Way"
var naturalCount :String
switch count {
case 0:
    naturalCount = "no"
    print(naturalCount)
    fallthrough
case 1...3:
    naturalCount = "a few"
    print(naturalCount)
case 4...9:
    naturalCount = "several"
    print(naturalCount)
case 10...99:
    naturalCount = "tens of"
    print(naturalCount)
case 100...999:
    naturalCount = "hundreds of"
    print(naturalCount)
case 1000...999_999:
    naturalCount =  "thousands of"
    print(naturalCount)
default:
    naturalCount = "millions and millions of"
    //print(naturalCount)
}



func join (s1:String, toString s2:String, withJoiner joiner:String) ->String {
    return s1 + joiner + s2
}
//print(join("hello", toString: "world", withJoiner: ","))


func sayHello(personName:String) ->String {
    return "hello," + personName + "!"
}
//print(sayHello("lossy"))


func max(x:Int, y:Int) -> Int {
    return x>y ? x : y
}
//print(max(3, y: 5))

func min() ->String {
    return "hello world"
}
//print(min())

//有多个可变参数
func sum(numbers:Int... ) -> Int{
    var total:Int = 0
    for num in numbers {
        total += num
    }
    print(total)
    return total
}
//sum(1, 2, 3, 4)

//去掉外部形参名用"_",同时给他一个默认参数，有外部参数使用外部参数，没有使用默认参数
func sayHi(msg:String, _ name:String = "lily") {
    print("\(msg) " + "\(name)")
}
//sayHi("hi");
//sayHi("hi", "tom")

//可变参数
func factorial(var number:Int) ->Int {
    var result:Int = 1
    while number > 1 {
        result = result * number
        number--
    }
    return result
}
//print(factorial(3))

// in-out 形参  有修饰，不能在有let、var修饰
func swap(inout a:Int, inout b:Int) {
    let tmp = a
    a = b
    b = tmp
}
var c1: Int = 1
var c2: Int = 3
swap(&c1, &c2)
//print("交换之后的值：a=\(c1),b = \(c2)")

//返回值类型
func area(width:Double, height:Double) -> (Double , Double) {
    let s = width * height
    let c = (width + height) * 2
    return (s , c)
}
//print(area(3.1,height: 3.4))


//函数类型作为参数
func addTwoInts(a: Int, b: Int) ->Int {
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) ->Int {
    return a * b
}
var mathFunction: (Int, Int) ->Int = addTwoInts
//print("Result:\(mathFunction(2,3))")

func printMathResult(mathFunction: (Int,Int) ->Int, a:Int , b:Int) {
    print("Result:\(mathFunction(a,b))")
}
//printMathResult(addTwoInts, a: 3, b: 5)


//函数类型作为返回值类型
func squre(num: Int) ->Int {
    return num * num
}
func cube(num:Int) -> Int {
    return num*num*num
}
func getMathFunc1(type type:String) -> (Int) -> Int {
    switch type {
    
        case "squre":
        return squre
    default:
        return cube
    
    }
}
var mathFunc = getMathFunc1(type: "other")
//print(mathFunc(5))


//函数重载 即swift允许定义多个同名函数，只要形参列表 或 返回值类型不同就行了
func test() {
    print("无参数的test()函数")
}
func test(msg:String) {
    print("重载的test()函数\(msg)")
}
func test(msg:String) ->String {
    print("重载的test()函数\(msg),带返回值")
    return "test"
}
func test(msg msg: String) {
    print("重载的test()函数,外部参数为\(msg)")
}
//报错，重复定义函数
//func test(message:String) {
//    
//}
//test()
//var result:Void = test(msg: "极客学院")
//var result2:String = test("Welcome，Geek")

var result3:String = "hello world"
//print(result3);

//swift即支持面向对象也支持面向过程的编程，而函数和闭包是面向过程编程中的基础语法，是必须理解和掌握的知识

//闭包
//嵌套函数
//func getMathFunc(type type:String) -> (Int) -> Int {
//    func squre(num:Int) -> Int {
//        return num * num
//    }
//    func cube(num:Int) -> Int {
//        return num * num * num
//    }
//    switch type {
//        case "squre":
//        return squre
//    default:
//        return cube
//    }
//}
//var mathFunc1 = getMathFunc(type: "squre")
//print(mathFunc1(3))


func getMathFunc(type type:String) -> (Int) -> Int {
    func squre(num:Int) -> Int {
        return num * num
    }
    func cube(num:Int) -> Int {
        return num * num * num
    }
    //返回的是闭包
    switch type {
    case "squre":
        return {(num:Int) -> Int in
            return num * num
            
        }
    default:
        return {(num: Int) -> Int in
            return num * num * num
            
        }
    }
}
//var mathFunc1 = getMathFunc(type: "squre")
//print(mathFunc1(3))
//mathFunc1 = getMathFunc(type: "other")
//print(mathFunc1(4))

//利用上下文推断类型
//var squre: (Int) -> Int = {(num:Int) -> Int in return num * num }
//print(squre(3))
//var squre: (Int) -> Int = {num in return num * num }
//print(squre(3))
//var squre: (Int) -> Int = {$0 * $0 }
//print(squre(3))


//值是一个闭包
//var result0: Int = {
//    var result = 1
//    for i in 1...$1 {
//        result *= $0
//    }
//    return result
//}(4, 3)
//
//print(result0)

//func A(a:Int) {}
//func B(b: Int, fn:(Int)->()) {}
//B(20, fn: A)



//尾随闭包
func someFunction(num:Int, fn:(Int) -> ()) {

    
}
//someFunction(20, fn: A)
//someFunction(20, fn: {})
//使用尾随闭包调用函数的格式
//someFunction(20){}


//捕获上下文中的常量和变量
func makeArr(ele:String) -> () -> [String] {
    //创建一个不包含任何元素的数组
    var arr:[String] = []
    func addElement() -> [String] {
        //向arr数组中添加一个元素
        arr.append(ele)
        print(arr)
        return arr
    }
    return addElement
}












































