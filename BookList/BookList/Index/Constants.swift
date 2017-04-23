//
//  Constants.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/13.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit
                                                        //DocumentationDirectory 导致错误
let DocumentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true)[0]

let MainWindow = UIApplication.sharedApplication().delegate!.window!!

var ScreenRatio:CGFloat {
    return ScreenWidth / ScreenHeight
}

var ScreenMidX:CGFloat {
    return CGRectGetMidX(UIScreen.mainScreen().bounds)
}

var ScreenMidY:CGFloat {
    return CGRectGetMidY(UIScreen.mainScreen().bounds)
}

var ScreenWidth:CGFloat {
    return UIScreen.mainScreen().bounds.size.width
}

var ScreenHeight:CGFloat {
    return UIScreen.mainScreen().bounds.size.height
}

class Constants: NSObject {
    
}












































