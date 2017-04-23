//
//  RatingView.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/11.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class RatingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var starMax = 5.0 // 最大评分
    var starHeight = 22.0 //星星高度
    var starSpace = 4.0 // 星星间距
    var emptyImageViews = [UIImageView]()
    var fullImageViews = [UIImageView]()
    
    var value = 0.0 {
        
        didSet {
            
            if value > starMax {
                value = starMax
            } else if value < 0 {
                value = 0
            }
            //刷新UI
            for (i, imageView) in fullImageViews.enumerate() {
                
                let i = Double(i)
                if value >= i + 1 {
                    imageView.hidden = false
                    imageView.layer.mask = nil
                } else if value > i && value < i + 1 {
                    let maskLayer = CALayer()
                    maskLayer.frame = CGRect(x: 0, y: 0, width: (value - i) * starHeight, height: starHeight)
                    maskLayer.backgroundColor = UIColor.redColor().CGColor
                    imageView.layer.mask = maskLayer
                    imageView.hidden = false
                } else {
                    imageView.hidden = true
                    imageView.layer.mask = nil
                }
                
            }
        }
    }
    
    static var KeyNoRating = "KeyNoRating"
    
    //没有评分
    static func showNoRating(view:UIView) {
        
        for  subview in view.subviews {
            if let subview = subview as? RatingView {
                subview.hidden = true
            }
        }
        
        //查找关联属性
        var label:UILabel! = objc_getAssociatedObject(view, &KeyNoRating) as? UILabel
        //找不到这个label，才去创建这个label
        if label == nil {
        
            label = UILabel(frame: view.bounds)
            label.font = UIFont.systemFontOfSize(13)
            label.text = "暂无评分"
            view.addSubview(label)
            //设置关联属性
            objc_setAssociatedObject(view, &KeyNoRating, label, .OBJC_ASSOCIATION_ASSIGN)
        }
        label.hidden = false
        
    }

    
    static func showInView(view:UIView, value:Double, starMax:Double = 5) {
        
        //解决cell每次重用都会调用showInView问题 ，它会重复的添加这个评分的控件。
        for subview in view.subviews {
            if let subview = subview as? RatingView {
                subview.value = value
                return
            }
        }
        
        let ratingView = RatingView(starHeight: Double(view.frame.size.height), starMax: starMax)
        ratingView.hidden = false
        view.addSubview(ratingView)
        ratingView.value = value
        
        //如果有这个label，把这个label给隐藏掉
        if let label = objc_getAssociatedObject(view, &KeyNoRating) as? UILabel {
            label.hidden = true
        }
    }
    
    
    init(starHeight:Double, starMax:Double) {
        self.starHeight = starHeight
        self.starMax = starMax
        self.starSpace = starHeight * 0.15
        let frame = CGRect(x: 0, y: 0, width: starHeight * starMax + starSpace * (starMax - 1), height: starHeight)
        super.init(frame:frame)
        
        for i in 0..<Int(starMax) {
        
            let i = Double(i)
            let emptyImageView = UIImageView(image: UIImage(named: "star_empty"))
            let fullImageView = UIImageView(image: UIImage(named: "star_full"))
            let frame = CGRect(x: starHeight * i + starSpace * i, y: 0, width: starHeight, height: starHeight)
            emptyImageView.frame = frame
            fullImageView.frame = frame
            emptyImageViews.append(emptyImageView)
            fullImageViews.append(fullImageView)
            addSubview(emptyImageView)
            addSubview(fullImageView)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

































