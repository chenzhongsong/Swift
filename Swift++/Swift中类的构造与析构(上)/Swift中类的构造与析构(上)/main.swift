//
//  main.swift
//  Swift中类的构造与析构(上)
//
//  Created by chenzhongsong on 16/3/21.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import Foundation

/*
    Swift面向对象高级--Swift 中类的构造与析构（上）
*/
/*
    构造就是init方法，是用来创建资源的，析构与构造对应、是用来销毁资源的。
    类支持继承，子类不仅包括自己定义的存储属性，还有从父类继承得到的存储属性，
    这些属性必须在构造过程中设置初始值，所以类的构造过程比较复杂
    结构体与枚举中不能定义析构器，类中可以定义析构器
*/

/*********************1.Swift 中的便利构造器和构造器链**********************/
/*
    本节知识点：
    1.类的构造器
    2.两段式构造
    3.构造器的继承和重写
    4.可能失败的构造器
    5.析构器
*/
/*
    类的构造
    1.类的指定构造器和便利构造器
    2.类的构造器链
    3.两段式构造的过程
*/
/*
    类的指定构造器和便利构造器
    1.一个类中至少有一个指定构造器，其必须负责初始化类中所有的实例存储属性
        (包括自己定义的属性和从父类继承得到的属性)，指定构造器：就是前面我们遇到的不加任何修饰符的构造器，只是一个init关键字来表示的构造器方法
    2.便利构造器属于次要的、辅助性的构造器
    3.类中可以不定义便利构造器，便利构造器必须调用同一个类中的其他构造器完成初始化
    4.便利构造器的语法格式：
        convenience init(形参){

        }
    5.只有类中才有便利构造器的概率
*/

class Apple {
    var name:String!
    var weight:Double
    //定义指定构造器
    init(name:String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    //定义便利构造器，使用convenience修饰
    convenience init(n name:String, w weight:Double) {
        //便利构造器必须调用同一个类中的其他构造器
        self.init(name: name, weight: weight)
        self.name = name
    }
}
var app1 = Apple(n: "红富士", w: 1.2)
var app2 = Apple(name: "花牛果", weight: 2.4)

/*
    Swift对构造器之间的调用链指定了如下3条规则：
    1.子类构造器必须调用直接父类的指定构造器（如果有父类）
    2.便利构造器必须调用同一个类中的其他构造器(可以是指定构造器，也可以是便利构造器)
    3.便利构造器调用的构造器链的最终节点必须是指定构造器，即便利构造器所调用的最后一定是一个指定构造器
    简化记忆为：
    1》指定构造器总是向上代理（调用父类构造器）
    2》便利构造器总是必须横向代理（调用当前类的其他构造器）
*/
class Fruit {
    var name:String
    var weight:Double
    init(name:String) { //①
        self.name = name
        self.weight = 0.0
    }
    //定义便利构造器
    convenience init (name:String, weight: Double) {//②
        //调用本类中的①号指定构造器
        self.init(name: name)
        self.weight = weight
    }
    //定义另一个便利构造器
    convenience init(n name:String, w weight: Double){ //③
        //调用本类中的②号指定构造器
        self.init(name: name)
    }
}
class Apples: Fruit {
    var color: String
    init(name: String, weight: Double, color: String){//④
        self.color = color
        //子类指定构造器必须调用父类的指定构造器，此处调用父类①号构造器
        super.init(name: name)
        self.weight = weight
    }
    init() { //⑤
        self.color = ""
        //子类指定构造器必须调用父类的指定构造器，此处调用父类①号构造器
        super.init(name: "")
        self.weight = 0.0
    }
    //定义一个便利构造器
    convenience init(name:String, color:String) {//⑥
        //调用本类中④号指定构造器
        self.init(name: name, weight:0.0, color: color)
    }
    convenience init(n name:String, c color: String) {//⑦
        //调用本类中⑥便利构造器
        self.init(name: name, color: color)
    }
}


/*********************2.Swift 中类的两段式构造（上）**********************/

/*
    所谓的两段式构造也就是类的构造过程必须分为两个阶段

    1.类的构造需要两个阶段
    第一阶段：

    图.........

    1>程序调用子类的某个构造器
    2>为实例分配内存，此时实例的内存还没有被初始化
    3>指定构造器确保子类定义的所有实例存储属性都已被赋予初值
    4>指定构造器将调用父类的构造器，完成父类定义的实例存储属性的初始化
    5>沿着调用父类构造器的构造器链一直往上执行，直到到达构造器链的最顶部
    
    总结来说：就是先为存储属性分配内容，使用该类的构造器初始化这个类所定义的存储属性，
            到达最顶部，各父类的指定构造器完成各自定义的存储实例属性


    构造器链中的指定构造器都有机会定制实例，两段式构造可以使构造过程更加安全，在构造过程中需要进行安全检查，
    这是接下来的四点安全检查。如果先对继承得到的属性赋予新值，然后调用父类构造器，那么父类构造器就会把指定构造器
    刚刚所赋予的新值给覆盖掉，所以要采用两段式构造进行安全检查，这是第一阶段

    第二阶段：
        1>沿着继承树往下，构造器此时可以修改实例属性、访问self，甚至可以调用实例方法
        2>最后，构造器链中的便利器都有机会定制实例和self。也就是在第二阶段中可以进行自定义

    图.........

    第二阶段主要是用来赋值或者是调用

    正如刚才所说，两段式构造可以使构造过程更加安全，它可以防止属性初始化之前被访问，也可以防止属性被
    另外一个构造器意外的被赋予不同的值，为了保证两段式构造被顺利完成，Swift提供了四种安全检查

    安全检查
    安全检查1：指定构造器必须先初始化当前类中定义的实例存储属性，然后才能向上调用父类构造器。
    安全检查2：指定构造器必须先向上调用父类构造器，然后才能对继承得到的属性赋值

    图.........

*/
class Fruits {
    var name:String
    init(name: String) {
        self.name = name
    }
}
class Appless: Fruits {
    var color:String
    init(color:String) {
//        print(self.color)  //错误的
        self.color = color
        print(self.color)
        self.color = "红色"
        print(self.color)
//        print(super.name) //错误的
        super.init(name: "花牛果")
        print(super.name)
        super.name = "红富士"
    }
}
var a = Appless(color: "绿色")
/*
    不管是本类的属性还是父类的属性都是先初始化才调用
*/




/*********************3.Swift 中类的两段式构造（下）**********************/

/*
    安全检查3：便利构造器必须先调用同一个类的其他构造器，然后才能对属性赋值。
            原因：如果先对属性赋值，然后在调用其他构造器的话，其他构造器就会把便利构造器刚刚所赋的值给覆盖掉

    图..............

*/
class Fruit_ {
    var name:String
    init(name: String) {
        self.name = name
    }
}
class Apple_: Fruit_ {
    var color: String
    init(color: String) {
        self.color = color
        print(self.color)
        super.init(name: "红富士")
        
    }
    //定义便利构造器
    convenience init(name:String, colo: String) {
        //调用其他构造器之前，不能访问或修改任何实例存储属性，下面的低吗出错
//        print(self.color)
//        super.name = name
        //调用本类其他构造器
        self.init(color:"红色")
    }
}
var a_ = Apple_(color: "red")


/*
        安全检查4：构造器在第一阶段完成之前，不能调用实例方法，不能读取实例属性。

        建议：为实例存储属性指定初始值。

*/































































































