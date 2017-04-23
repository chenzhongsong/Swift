//: Playground - noun: a place where people can play

import UIKit

/*
    guard 用法：
    guard 在前面解的包，在后面是可以用的，而if不可以

    .可以把guard 近似的看做是Assert，但是你可以优雅的退出而非奔溃
    .guard中解包得到的值可以用于后面的代码
*/

func checkup(person: [String: String]) {
    
    
    guard let id = person["id"] else {
        print("没有身份证，不能进入考场");
        return
    }
    
    guard let examNumber = person["examNumber"] else {
        print("没有准考证，不能进入考场！");
        return
    }
    
    print("您的身份证号：\(id),准考证号为：\(examNumber)，请进入考场！")
}
//checkup(["id":"123456"])
//checkup(["examNumber":"654321"])
checkup(["id":"123456","examNumber":"654321"])


/*
    属性观察者
*/

let MaxValue = 999
let MinValue = -999

var number = 0 {

//赋值之前触发
willSet {
    print("将从\(number)变成\(newValue)")
}

//赋值之后触发
didSet {
    if number > MaxValue {
        number = MaxValue
    } else if number < MinValue {
        number = MinValue
    }
    print("已经从\(oldValue) 变成\(number)")
}

}
number = 1000
number

/*
    @IBOutlet weak var maLable: UILable! {
        didSet {
            myLabel.textColor = UIColor.purpleColor()
        }
    }

    .同样可以设置NSLayoutConstraint的constant
*/


/*
    扩展 extension  
    就是向一个已有的类、结构体、枚举类型或协议类型添加新功能。这包括在没有权限获取原始代码的情况下扩展类型的能力(即逆向建模)

    Swift可以扩展协议，增加新的属性和方法

    在Swift 2.0中，可以对协议进行属性或者方法的扩展，和扩展类与结构体类型，这让我们开启了面向协议编程的编程。
*/

extension Int {
    
    func times(closure:(() -> ())?) {
        
        if self >= 0 {
            for _ in 0..<self {
                closure?()
            }
        }
    }
}
5.times { () -> () in
    print("something")
}


extension CustomStringConvertible {
    var upperDescription:String {
        return self.description.uppercaseString
    }
}
//协议扩展
["key":"value"].description
["key":"value"].upperDescription




/*
    map flatMap filter

    flatMap 会把值为nil的过滤掉 而map不会  filter是把满足一定条件值给筛选出来

    .map: 得到一个由闭包里面的返回值组成的新序列
    .flatMap: 与map类似的功能，但是会过滤掉返回值里面的nil值
    .filter: 得到一个由闭包返回值为true的值组成的新序列
*/

var result = [1,2,3,4,5].map{$0 * 2}
result
var result1 = [1,2,3,4,5].flatMap{$0 * 2}
result1

var images = (1...7).map{ UIImage(named: "image\($0).png")}
images.count
images
var images1 = (1...7).flatMap{ UIImage(named: "image\($0).png")}
images1.count
images1

result = [1,2,3,4,5].filter{$0 > 2}
result



/*
    单例
*/

class TestObject {
    
    //static说明属性testObject属于这个类，而不属于具体的某个对象
    
    private static let testObject = TestObject()
    
    static var sharedInstance : TestObject {
        return testObject
    }
    
    private init() {
        
    }
    
    func test() {
    }
}
TestObject.sharedInstance
TestObject.sharedInstance.test()































