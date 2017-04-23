//
//  NetManager.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/1.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast//轻量级的提示

struct  NetManager {

    static let KeyBooks = "books"
    static let pageSize = 10 //每页数量
    static let URLStringBooks = "https://api.douban.com/v2/book/search"
    static let netError = "网络异常，请检查网络"
    
    static let NotificationUserInfo = "UserInfo"
    static var isRequestUserInfo = false // 是否正在请求用户信息
    
    //登录后 的 个人详情页
    static let URLStringGetUserInfo = "https://api.douban.com/v2/user/"
    static func getUserInfo() {
        
        if isRequestUserInfo {
            return
        }
        
        GET(URLStringGetUserInfo + User.shareUser.douban_user_id, parameters: nil, showHUD: false, success: { (responseObject) -> Void in
            
            print(responseObject)
            User.shareUser.updateUserInfoWithDict(responseObject as? [String:NSObject] ?? [:])
            NSNotificationCenter.defaultCenter().postNotificationName(NotificationUserInfo, object: nil)
            isRequestUserInfo = false
            
            }) { (error) -> Void in
                
                print(error)
                isRequestUserInfo = false
        }
    }
    
    
    //OAuth登录
    struct OAuthLogin {
        static let URLStringLogin = "https://www.douban.com/service/auth2/token"
        //应用的唯一标识，对应于APIKey
        static let client_id = "044a3a0984e7ef550cdeae1c8eb7cdff"
        static let client_secret = "eb0d6aeeede176e6"
        static let redirect_uri = "https://www.baidu.com"
        
        static var URLStringGetCode = "https://www.douban.com/service/auth2/auth?client_id=\(client_id)&&redirect_uri=\(redirect_uri)&&response_type=code"
        
        
        //用返回的code发送post请求 登录
        static func loginWithCode(code:String, resultColsure:((Bool)->Void)) {
            NetManager.POST(URLStringLogin, parameters: ["client_id":client_id,"client_secret":client_secret,"redirect_uri":redirect_uri,"grant_type":"authorization_code","code":code], showHUD: true, success: { (responseObject) -> Void in
                //返回用户信息
                print(responseObject)
                
                if let dict = responseObject as? [String:NSObject] {
                    User.shareUser.loginWithDict(dict)
                    resultColsure(true)
                } else {
                    resultColsure(false)
                }
                
                
                
                }) { (error) -> Void in
                    
                    resultColsure(false)
            }
        }
    }
    
    
    
    
    //详情页 评论列表
    static func getReviewsWithBookId(bookId:String, page:Int, resultClosure:(Bool, [Review]!)->Void) {
        
        GET("https://api.douban.com/v2/book/\(bookId)/reviews", parameters: ["start":page*pageSize], showHUD: false, success: { (responseObject) -> Void in
            
            var reviews = [Review]()
            if let reviewsArray = (responseObject as? [String:NSObject])?["reviews"] as? [[String:NSObject]] {
                for dict in reviewsArray {
                    reviews.append(Review(dict: dict))
                }
            }
            resultClosure(true,reviews)
            
            }) { (ErrorType) -> Void in
                resultClosure(false,nil)
        }
    }
    
    // 获取图书 搜索 title 列表
    static func getBookTitles(tag:String, page:Int, resultClosure:(([String]) -> Void)) {
        
        NetManager.GET(URLStringBooks, parameters: ["tag":tag,"start":page * pageSize,"count":pageSize, "fields":"title"], showHUD: false, success: { (responseObject) -> Void in
            
                var searchTitles = [String]()  //先清零
                if let dict = responseObject as? [String:NSObject],
                    array = dict[self.KeyBooks] as? [[String:NSObject]] {
                        
                        for dict in array {
                            if let title = dict["title"] as? String {
                                searchTitles.append(title)
                            }
                        }
                        
                }
                resultClosure(searchTitles)
            
            }) { (error) -> Void in
                print(error)
                
            
                
        }
        
        
    }
    
    
    // 获取图书列表
    static func getBooks(tag:String, page:Int, resultClosure:((Bool, [Book]!) -> Void)) {
    
        NetManager.GET(URLStringBooks, parameters: ["tag":tag,"start":page * pageSize,"count":pageSize], showHUD: false, success: { (responseObject) -> Void in
            
                var books = [Book]()  //先清零
                if let dict = responseObject as? [String:NSObject],
                    array = dict[self.KeyBooks] as? [[String:NSObject]] {
                        
                        for dict in array {
                            books.append(Book(dict: dict))
                        }
                        
                }
                resultClosure(true,books)
            
            }) { (error) -> Void in
                print(error)
                
                resultClosure(false,nil)
                
        }
        
    
    }
    
    //静态函数(类型函数)，属于这个类型本身
    static func GET(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()//推荐iOS7以后使用的manager
        manager.requestSerializer.timeoutInterval =  10
        
        let mainWindow = UIApplication.sharedApplication().delegate?.window!
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        
        manager.GET(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            
                success?(responseObject as? NSObject)
            
            }) { (task, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
    
    
    
    static func POST(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()//推荐iOS7以后使用的manager
        manager.requestSerializer.timeoutInterval =  10
        
        let mainWindow = UIApplication.sharedApplication().delegate?.window!
        
        if showHUD {
            MBProgressHUD.showHUDAddedTo(mainWindow, animated: true)
        }
        
        manager.POST(URLString, parameters: parameters, success: { (task, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
            }
            success?(responseObject as? NSObject)
            
            }) { (task, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(mainWindow, animated: true)
                    mainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
    
}


















































































































































