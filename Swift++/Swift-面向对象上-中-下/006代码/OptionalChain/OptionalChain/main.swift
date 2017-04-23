//
//  main.swift
//  OptionalChain
//
//  Created by CarolWang on 15/4/14.
//  Copyright (c) 2015年 com.jikexueyuan. All rights reserved.
//

import Foundation

//创建三个关联类
class Customer
    {
    var name = ""
    var emp: Employee?
    init(name : String){
        self.name = name
    }
    
    
    // 定义一个常量类型的employees数组，用于模拟系统中所有员工
    let employees = [
        Employee(name:"张三" , title:"销售客服"),
        Employee(name:"小明" , title:"售后客服"),
        Employee(name:"Han" , title:"普通客服"),
        Employee(name:"Better" , title:"销售主管")
    ]
    // 定义一个方法，该方法可根据员工名返回对应的员工，返回值为可选类型
    func findEmp(empName: String) -> Employee!
    {
        for emp in employees {
            if emp.name == empName {
                return emp
            }
        }
        return nil
    }

}



class Company
    {
    var name = ""
    var addr = ""
    init(name: String , addr: String){
        self.name = name
        self.addr = addr
    }
}


class Employee
        {
        var name = "Lily"
        var title = "行政"
        var company: Company!
        init(name:String , title: String) {
            self.name = name
            self.title = title
        }
        func info() {
            print("本员工名为\(self.name)，职位是\(self.title)")
        }
}

var c = Customer(name:"Damon")
var emp = Employee(name:"Elena" , title:"Student")
// 设置Customer关联的Employee实例
c.emp = emp
    // 设置Employee关联的Company实例
emp.company = Company(name:"极客学院" , addr:"北京市")

//println("为\(c.name)服务的公司是:\(c.emp?.company?.name)")

//第二种情况
//var c2 = Customer(name:"Lucky")
//// 设置Customer关联的Employee实例
//c2.emp = Employee(name:"Snow" , title:"客服")
//// 使用可选链访问属性
////println("为\(c2.name)服务的公司是：\(c2.emp?.company?.name)")

//
//    
var c3 = Customer(name:"Paul")
// 使用可选链访问属性
//println("为\(c3.name)服务的公司是：\(c3.emp?.company?.name)")



/*
    1.可选链访问方式：将强制解析的感叹号换成？，在隐式解析的后面也添加？后缀。
    2.可选链会自动判断程序访问的关联实例是否为nil
*/
    
    // 2.使用可选链调用方法
//c3.findEmp("张三")?.info()
//c3.findEmp("小明")?.info()
//
    
var dict = [Int : Customer]()
dict[1] = Customer(name:"Han")
dict[2] = Customer(name:"Angle")


    // 3.使用可选链访问下标
dict[1]?.findEmp("Better")?.info()
dict[4]?.findEmp("Better")?.info()

