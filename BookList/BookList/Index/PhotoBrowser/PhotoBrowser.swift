//
//  PhotoBrowser.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/13.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit
import SnapKit

class PhotoBrowser: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let KeyPhotoBrowserCell = "PhotoBrowserCell"
    
    var imageView:UIImageView!
    var URLStrings = [String]()

    @IBOutlet weak var viewBackground: UIView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    static func showFromImageView(imageView:UIImageView, URLStrings:[String], index:Int) -> PhotoBrowser {
        
        let browser = NSBundle.mainBundle().loadNibNamed("PhotoBrowser", owner: nil, options: nil)[0] as! PhotoBrowser
        browser.imageView = imageView
        browser.configureViewBrowser(URLStrings)
        browser.animateImage(index)
        return browser
    }
    
    func colseBrowser() {
        removeFromSuperview()
    }
    
    func configureViewBrowser(URLStrings:[String]) {
        
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "colseBrowser"))
        
        self.URLStrings = URLStrings
        MainWindow.addSubview(self)
        collectionView.registerNib(UINib(nibName: KeyPhotoBrowserCell, bundle: nil), forCellWithReuseIdentifier: KeyPhotoBrowserCell)
        self.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(MainWindow)
        }
    }
    
    //做动画
    func animateImage(index:Int) {
        
        
        
        //点击的ImageView 相对于主window的frame
        var startFrame = self.imageView.superview!.convertRect(self.imageView.frame, toView: MainWindow)
        var endFrame = UIScreen.mainScreen().bounds
        
        if let image = self.imageView.image {
            
            let ratio = image.size.width / image.size.height
            //说明图片是长条的
            if ratio < (startFrame.width / startFrame.height) {
                let midX = CGRectGetMidX(startFrame)
                startFrame.size.width = startFrame.height * ratio
                startFrame.origin.x = midX - startFrame.size.width / 2
            } else {
                let midY = CGRectGetMidY(startFrame)
                startFrame.size.height = startFrame.width / ratio
                startFrame.origin.y = midY - startFrame.size.height / 2
            }
            
            if ratio < ScreenRatio {
                endFrame.size.width = ScreenHeight * ratio
                endFrame.origin.x = ScreenMidX - endFrame.size.width / 2
            } else {
                endFrame.size.height = ScreenHeight / ratio
                endFrame.origin.y = ScreenMidY - endFrame.size.height / 2
            }
            //图片设置完毕
            
            //开始做动画
            let animateImageView = UIImageView(frame: startFrame)
            
            MainWindow.addSubview(animateImageView)
            
            animateImageView.image = imageView.image
            animateImageView.contentMode = .ScaleAspectFit
            viewBackground.alpha = 0
            self.imageView.hidden = true
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                
                animateImageView.frame = endFrame
                self.viewBackground.alpha = 1
                
                }, completion: { (result) -> Void in
                    
                    self.imageView.hidden = false
                    self.collectionView.contentOffset = CGPointMake(ScreenWidth * CGFloat(index), 0)
                    self.collectionView.hidden = false
                    animateImageView.removeFromSuperview()
            })
            
        }
        
       
    }
    //处理旋转
    static func reloadForScreenRotate() {
        for view in MainWindow.subviews {
            if let view = view as? PhotoBrowser {
                view.reloadForScreenRotate()
            }
        }
    }
    
    func reloadForScreenRotate() {
        collectionView.reloadData()
        collectionView.contentOffset.x = collectionView.contentOffset.x * ScreenWidth / ScreenHeight
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: ScreenWidth, height: ScreenHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return URLStrings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(KeyPhotoBrowserCell, forIndexPath: indexPath) as! PhotoBrowserCell
        cell.imageView.sd_setImageWithURL(NSURL(string: URLStrings[indexPath.row]))
        
        return cell
    }
 }






















































