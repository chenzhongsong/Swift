//
//  main.swift
//  Simple2
//
//  Created by CarolWang on 14/12/7.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

import Foundation

print("Hello, World!")
//1.类型转换
let a: UInt8 = 10
let b: UInt16 = 100
print("\(UInt16(a) + b)")
print("\(a + UInt8(b))")

let sa = 3
let pi = 3.1415
let add = Double(sa) + pi
let max = sa + Int(pi)
print(max)
print(add)

//2.类型别名  前面添加typealias关键字
typealias AudioSample = UInt16
var maxValue = AudioSample.min
print(maxValue)

//3.元组  里可以是任意类型
let people = (18,"xiaoming")
let (age, name) = people
print("The age is \(age)")
print("The name is \(name)")
//分解时候要忽略的部分用 _ 表示
let (justAge, _) = people
print("The age is \(justAge)")
print("\(people.0)")
//定义元组的时候，给单个元素命名
let rec = (w : 10, h: 20)
//println("\(rec.w)")
print("\(rec.h)")
print(rec.w)

//4.可选类型：处理值可能缺失的情况
//let Str = "1234"
//let convertNumber = Str.Int
//print(convertNumber)//convertNumber 是 optional Int 或者 Int?
//if convertNumber != nil {
//    print(convertNumber!)//可选值的强制解析
//}
////可选绑定:可以用在if和while语句中来对可选类型的值进行判断并把值赋给一个常量或者变量。
//if let  actualNumber = Str.Int{
//    print(actualNumber)
//}

// nil 表示一个确定的值，表示值缺失
var serverCode: Int? = 404
serverCode = nil//现在 serverCode 不包含值
var suuny: String?

//隐式解析可选类型 :第一次被赋值之后，可以确定一个可选类型总会有值,不要在变量没有值的时候使用
var possibleStr: String! = "jikexueyuan"
print(possibleStr)

//5.断言
let age2 = -10
assert(age2 >= 0, "年龄要大于0")