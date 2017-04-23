//
//  User.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/15.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    
    
    //user info
    /*
    alt = "http://www.douban.com/people/141875052/";
    avatar = "https://img3.doubanio.com/icon/u141875052-2.jpg";
    created = "2016-02-13 17:18:28";
    desc = "\U6781\U5ba2\U5b66\U9662 Swift \U56fe\U4e66\U5c55\U793a\U9879\U76ee\U5f00\U53d1\U5b9e\U6218";
    id = 141875052;
    "is_banned" = 0;
    "is_suicide" = 0;
    "large_avatar" = "https://img3.doubanio.com/icon/up141875052-2.jpg";
    "loc_id" = 118183;
    "loc_name" = "\U5b89\U5fbd\U5408\U80a5";
    name = jikexueyuan;
    signature = "";
    type = user;
    uid = 141875052;
    */
    
    let KeyAlt = "alt"
    let KeyAvatar = "avatar"
    let KeyCreated = "created"
    let KeyDesc = "desc"
    let KeyId = "id"
    let KeyIs_banned = "is_banned"
    let KeyIs_suicide = "is_suicide"
    let KeyLarge_avatar = "large_avatar"
    let KeyLoc_id = "loc_id"
    let KeyLoc_name = "loc_name"
    let KeyName = "name"
    let KeySignature = "signature"
    let KeyType = "type"
    let KeyUid = "uid"
    
    var alt = "";
    var avatar = "";
    var created = "";
    var desc = "";
    var id = 0;
    var is_banned = 0;
    var is_suicide = 0;
    var large_avatar = "";
    var loc_id = 118183;
    var loc_name = "";
    var name = "";
    var signature = "";
    var type = "";
    var uid = 0; //返回的 和 douban_user_id 这个一样
    
    func updateUserInfoWithDict(dict:[String:NSObject]) {
        alt = dict[KeyAlt] as? String ?? "" //个人主页
        avatar = dict[KeyAvatar] as? String ?? ""
        created = dict[KeyCreated] as? String ?? ""
        desc = dict[KeyDesc] as? String ?? ""
        is_banned = dict[KeyIs_banned] as? Int ?? 0
        is_suicide = dict[KeyIs_suicide] as? Int ?? 0
        large_avatar = dict[KeyLarge_avatar] as? String ?? ""
        loc_id = dict[KeyLoc_id] as? Int ?? 0
        loc_name = dict[KeyLoc_name] as? String ?? ""
        name = dict[KeyName] as? String ?? ""
        signature = dict[KeySignature] as? String ?? ""
        type = dict[KeyType] as? String ?? ""
        
        
    }
    

    //OAuth
    /*
    "access_token" = 2dadb9228c7e117089092b67a57a3450;
    "douban_user_id" = 141875052;
    "douban_user_name" = jikexueyuan;
    "expires_in" = 604800;
    "refresh_token" = da0347bd85e326918e09d73891a973b3;
    */
    
    let KeyAccess_token = "access_token"
    let KeyDouban_user_id = "douban_user_id"
    let KeyDouban_user_name = "douban_user_name"
    let KeyExpires_time = "expires_in"
    let KeyRefresh_token = "refresh_token"
    
    var access_token = ""
    var douban_user_name = ""
    var expires_time = 0.0 //相对于1970的过期时间
    var refresh_token = ""
    var douban_user_id = "" { //改变的时候调用
        
        didSet {
            NetManager.getUserInfo()
        }
        
    }
    
    
    //添加登录状态的  计算型属性
    var isLogin:Bool {
        //NSDate().timeIntervalSince1970 获取当前时间
        if !access_token.isEmpty && expires_time > NSDate().timeIntervalSince1970 {
            return true
        } else {
            return false
        }
    }
    
    func loginWithDict(dict:[String:NSObject]) {
        
        if let expires_in = dict[KeyExpires_time] as? Double {
            expires_time = NSDate().timeIntervalSince1970 + expires_in
        }
        
        access_token = dict[KeyAccess_token] as? String ?? ""
        douban_user_id = dict[KeyDouban_user_id] as? String ?? ""
        douban_user_name = dict[KeyDouban_user_name] as? String ?? ""
        refresh_token = dict[KeyRefresh_token] as? String ?? ""
        
        //把用户信息存到文件里
        NSKeyedArchiver.archiveRootObject(self, toFile: DocumentPath + "/users")
    }
    
    //在这里构造这个单利的属性 从文件里解析这个用户
    static let shareUser = NSKeyedUnarchiver.unarchiveObjectWithFile(DocumentPath + "/users") as? User ?? User()
    
    
    
    
    //如果需要当前对象需要归档 解档  需要实现NSCoding 协议
    required init?(coder aDecoder: NSCoder) {
        
        expires_time = aDecoder.decodeObjectForKey(KeyExpires_time) as? Double ?? 0.0
        access_token = aDecoder.decodeObjectForKey(KeyAccess_token) as? String ?? ""
        douban_user_id = aDecoder.decodeObjectForKey(KeyDouban_user_id) as? String ?? ""
        douban_user_name = aDecoder.decodeObjectForKey(KeyDouban_user_name) as? String ?? ""
        refresh_token = aDecoder.decodeObjectForKey(KeyRefresh_token) as? String ?? ""
    }

    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(expires_time, forKey: KeyExpires_time)
        aCoder.encodeObject(access_token, forKey: KeyAccess_token)
        aCoder.encodeObject(douban_user_id, forKey: KeyDouban_user_id)
        aCoder.encodeObject(douban_user_name, forKey: KeyDouban_user_name)
        aCoder.encodeObject(refresh_token, forKey: KeyRefresh_token)
        
        
    }

    //因为用户是全局的  所以需要用单利来访问这个对象 ，首先设置它的init方法为私有的
    private override init() {
        super.init()
    }

}

































