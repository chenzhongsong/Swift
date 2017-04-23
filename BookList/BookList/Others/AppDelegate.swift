//
//  AppDelegate.swift
//  BookList
//
//  Created by chenzhongsong on 16/3/31.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

/*
    framework 是iOS8新加的对动态库的支持，CocoaPods是iOS的库管理工具，可以自动帮我们管理库之间的依赖，有了它就可以把更多的时间用在业务开发上。

    framework介绍：iOS8后苹果开放了framework，也就是动态库的功能，苹果之前的framework不是动态的，根源还是静态的。
                    和静态库在编译时和App代码链接一并打进同一个二进制包中不同，动态库可以在运行时手动加载，这样就可以做很多事情：
                    1.应用插件化
                    2.软件版本实时模块升级
                    3.共享可执行文件(仅可用于App Extension)

    管理framework：
                .user_frameworks!   以动态库framework的形式引入那些pod的动态库
                .CocoaPods生成一个动态框架，其中包含所有pods而非一个静态库
                .import moduleName   动态框架可以用import这个动态框架的名字moduleName直接导入这个框架底下的所有的API
*/


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

