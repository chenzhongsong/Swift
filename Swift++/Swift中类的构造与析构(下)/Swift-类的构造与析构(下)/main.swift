//
//  main.swift
//  Swift-类的构造与析构(下)
//
//  Created by chenzhongsong on 16/3/21.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation

/*
    类的构造器
    1.构造器的继承与重写
    2.类与可能失败的构造器
*/


/**********************1.Swift 中构造器的继承与重写********************/

/*
    构造器的继承
    1.Swift的子类不会自动继承父类的构造器，若继承，则满足如下规则：
        1>如果子类没有提供任何指定构造器，那么它将自动继承父类的所有指定构造器。
        2>如果子类实现了父类所有的指定构造器，无论如何实现的(不管是通过继承还是通过编码实现)，都将自动继承父类的所有便利构造器
*/
/*
    构造器的重写
    1.子类构造器重写了父类的 指定构造器，必须添加override修饰符。
    2.子类中定义的构造器只是与父类中 便利构造器的形参列表、外部形参名相同，不算重写
*/
//构造器的继承
class Fruit {
    var name:String
    var weight: Double
    //定义一个指定构造器
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    //定义两个便利构造器
    convenience init(name: String) {
        self.init(name: name, weight: 0.0)
    }
    convenience init(){
        self.init(name: "水果")
        self.weight = 1.0
    }
}
//该类提供了指定构造器，并未实现父类所有的指定构造器
class Apple: Fruit {
    var color: String
    /*定义一个指定构造器，不能继承父类的指定构造器，而且Apple这个类没有实现父类所有的指定构造器，
      由规则2  就不能继承父类的便利构造器。Apple这个类中就只有两个构造器*/
    init(name: String, color: String, weight: Double) {
        self.color = color
        super.init(name: name, weight: weight)
    }
    //定义一个便利构造器
    convenience init(name: String,color: String) {
        self.init(name:name, color: color, weight: 0.0)
    }
}
//该类没有定义任何构造器，由规则1，它可以得到父类所有的指定构造器，由规则2，它可以继承父类所有的便利构造器
class Fu:Apple {
    var vitamin: Double = 0.21
}

//构造器的重写
class Fruit_ {
    var name: String
    var weight:Double
    init (){
        self.name = ""
        self.weight = 0.0
    }
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    convenience init(name: String) {
        self.init(name:name, weight: 0.0)
    }
    convenience init (_ name: String) {
        self.init(name: name)
    }
}
class Apple_: Fruit_ {
    var color: String
    //重写父类的指定构造器
    override init(name: String, weight: Double) {
        self.color = "默认色"
        //调用父类构造器
        super.init(name: name, weight: weight)
    }
    //定义指定构造器
    init(name: String) {
        self.color = "默认色"
        super.init(name: name, weight: 0.0)
    }
    //便利构造器
    convenience init(name: String, weight: Double, color: String) {
        self.init(name:name, weight: weight)
        self.weight = weight
    }
    //使用便利构造器重写父类指定构造器
    override convenience init() {
        self.init(name:"苹果", weight:0.0, color:"粉红")
    }
}


/*
    类与可能失败的构造器
    
    对于值类型的可能失败的构造器而言，在该构造器实现体的任意地方都可以添加return nil 来触发构造失败

    而 类中
    1.可能失败的构造器必须满足如下两个条件才能触发：
        1>该类中的所有实例存储属性都已被赋初始值；
            这初始值可以是程序显示指定初始值，也可以是系统隐式分配默认的初始值
        2>所有的构造器调用都已经被执行。
            即：return nil 这条语句不能够位于self.init或super.init 这些代码之前

*/
class User {
    var name: String //系统没有分配初始值
    init?(name: String) {
        self.name = "" //必须先分配初始值
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class User_ {
    var name: String! //系统分配初始值nil
    init?(name: String) {
//        self.name = ""
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}




/**********************2.Swift 中可能失败的构造器的传播(调用)与重写********************/
/*
    类、结构体、枚举中的构造器可以横向的调用该类、结构体、枚举中可能失败的构造器，
    类似的 子类的可能失败的构造器也可以向上调用父类的可能失败的构造器
*/
/*
    1.可能失败的构造器可以调用同一个类中的普通构造器
    2.普通构造器不能调用同一个类中可能失败的构造器
    3.在结构体中，普通构造器却可以调用同一个结构体中可能失败的构造器

    因为构造器是可以调用的，所以它会产生传播，因此当可能失败的构造器在构造过程失败之后，
    这种失败的行为就会立刻阻止原来构造器代码继续向下执行
*/
//传播(调用)
class Users {
    var name: String //系统没有分配初始值
    init?(name: String) {
        self.name = "" //必须先分配初始值
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}
class Student: Users {
    var grade: Int! //默认值是nil
    init!(name: String, grade: Int) {
        //调用父类可能失败的构造器
        super.init(name: name)
        print("---super.init(name: \(name))之后---")
        //如果grade小于1，使用return nil 触发构造失败 /*对于类的可能失败的构造器而言，只有当构造器代理都被执行之后，才能够使用return nil  触发构造失败   所谓的构造器代理就是在一个构造器当中使用另一个构造器  */
        if grade < 1 {
            return nil//必须位于super.init之后
        }
        self.grade = grade
    }
}
let s1 = Student(name: "Tom", grade: 4)//不会触发构造失败
print("s1的name:\(s1.name),s1的grade:\(s1.grade)")
let s2 = Student(name: "Jerry", grade: 0) //会触发构造失败，但是向上调用父类构造器的时候不会触发构造失败，因为name不为空
print(s2==nil)
let s3 = Student(name: "", grade: 3)
print(s3==nil)



/********重写可能失败的构造器*********/
/*
    子类可以重写父类可能失败的构造器,重写的方法既可以用可能失败的构造器来重写父类的可能失败的构造器，也可以用普通的构造器来重写父类的可能失败的构造器

    1.子类可以用可能失败的构造器或者普通构造器来重写父类中的可能失败的构造器。
    2.子类的普通构造器不能向上调用父类的可能失败的构造器。
        即可以进行重写，但不能进行调用
        对于类的构造器而言，普通构造器永远不能调用可能失败的构造器，不管是父类的可能的失败的构造器，还是同一个类中可能失败的构造器
 
*/

//重写

class Bird {
    var name: String!   //默认值是nil
    //定义普通构造器
    init(){}
    //定义可能失败的构造器
    //init!(name: String){}
    init?(name: String) { //后面是?的需要进行强制解析，后面是!不需要进行强制解析
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}
class Sparrow: Bird {
    var weight: Double!
    init?(name:String, weight:Double) {
        //由于该构造器是可能失败的构造器，可以调用父类可能失败的构造器
        super.init(name: name)
        if weight <= 0 {
            return nil
        }
        self.weight = weight
        self.name = name
    }
    //使用普通构造器重写父类的构造器
    override init(name: String) {
        //由于该构造器是普通构造器，因此不能调用父类可能失败的构造器
        //因此只能调用父类的普通构造器
        super.init()
            //super.init(name:"")//与父类当中的init!(name: String)对应
        if name.isEmpty {
            super.name = "麻雀"
        }
        self.name = name
    }
    
    
}
let sp1 = Sparrow(name: "")
print("sp1的name：\(sp1.name)")
let sp2 = Sparrow(name: "", weight: 2.2)
print(sp2 == nil)
let sp3 = Sparrow(name: "小黄醉", weight: 0)
print(sp3 == nil)
/*
    需要注意的是 类中的构造器永远不能调用需要强制解析的可能失败的构造器，
    但可以调用支持隐式解析的可能失败的构造器。
    
    可能失败的构造器的传播：可能失败的构造器可以调用同一个类中普通构造器，但是普通构造器不能调用同一个类中可能失败的构造器，这一点在结构体当中却是可以成立的

    关于可能失败的构造器的传播与重写 就介绍到这里  下一节介绍子类当中必须包含的构造器以及析构器
*/



/**********************3. required 构造器和析构器********************/
/*
    子类当中必须包含的构造器以及析构器
*/
/*
    1.Swift允许在父类构造器前添加required关键字，用于声明所有子类必须包含该required构造器。
        //required关键字只是要求所有的子类必须包含这个构造器，但是是通过继承还是自己编码实现的，不管
    2.父类中声明的required构造器即可以是指定构造器，也可以是便利构造器。
        //即子类打算自己编码来包含required构造器的时候，是采用指定构造器，还是便利构造器，这是无所谓的。总之:required只是要求所有的子类必须包含required构造器，至于由子类编码实现还是继承获得，那他实现的是采用指定构造器还是便利构造器，这些都不重要
*/
class Fruit_A{
    var name: String
    var weight: Double
    //这是一个指定构造器
    required init(name: String) {//①
        self.name = name
        self.weight = 0.0
    }
    //这是一个便利构造器
    required convenience init(name: String, weight: Double) {//②
        self.init(name: name)
        self.weight = weight
    }
    //① ② 都是需要子类当中进行重写的
}
class Apple_A : Fruit_A {
    var color: String
    //指定构造器重写了父类中的便利构造器
    required init(name: String, weight: Double) { //③  重写②
        self.color = "粉红"
        super.init(name: name)
    }
    //子类自己定义的，与父类中required构造器没有关系
    init(color: String) {
        self.color = color
        super.init(name: "")
    }
    //子类的便利构造器重写了父类的指定构造器
    required convenience init(name: String) { //④  重写①
        self.init(color: "aaa")
        super.name = name
    }
}
//该类将继承得到父类的required构造器。
class Grape_A: Fruit_A {
    var sugarRate: Double = 0.45
}

/*
    析构器（程序释放一些物理资源，不是内存，用到析构器。内存释放是由系统自动完成的）
    
    1.析构器是一个名为deinit的函数，不需要使用func关键字，无参数和返回值。
        //析构器没有小括号，所以不能进行重载
    2.析构器在实例释放之前由系统自动调用，不能主动调用析构器。
    3.子类自动继承父类的析构器，而且无论如何，子类析构器一定会调用父类析构器。
    4.析构器可以访问该实例的所有实例存储属性，或者根据这些属性来关闭资源
*/
class Fruit_B {
    var name: String
    var weight: Double
    //定义指定构造器
    init(name: String) {
        self.name = name
        self.weight = 0.0
    }
    //定义析构器
    deinit {
        print("程序准备释放Fruit_B")
        //此处可访问实例属性，可用于释放资源
    }
}
class Apple_B:Fruit_B {
    var color: String
    //定义指定构造器
    init(name: String, weight: Double, color: String) {
        self.color = color
        super.init(name: name)
    }
    //定义析构器
    deinit {
        print("程序准备释放Apple_B")
        //此处可访问实例属性，可用于释放资源
    }
}
var ap: Apple_B? = Apple_B(name: "红富士", weight: 0.34, color: "红色")
print(ap!.name + "--->" + ap!.color)
ap = nil
//此时引用计数为0，程序无法再访问Apple_B
/*
    析构器是在实例释放之前由系统自动调用的，不需要去主动去调用析构器，只有析构器被调用完成之后，这个实例才会被销毁，析构器可以访问实例的所有存储属性。
*/
/*
    类的构造器和析构器总结

    1.类的指定构造器和便利构造器。语法格式以及调用
    2.类的构造器链
*/





























