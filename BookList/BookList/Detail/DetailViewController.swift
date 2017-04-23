//
//  DetailViewController.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/12.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var book:Book!
    var page = 0
    var reviews = [Review]()
    
    var headerView:DetailHeaderView!
    var URLStrings = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.tableHeaderView = NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: nil, options: nil)[0] as! DetailHeaderView
//        self.automaticallyAdjustsScrollViewInsets = true;

        if book != nil {
            DetailHeaderView.showInVC(self)
            labelTitle.text = book.title
        } else {
            
            tableView.footerEndRefreshNoMoreData()
        }
        
        tableView.estimatedRowHeight = 112
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        
    }
    
    func showImage(gesture:UIGestureRecognizer) {
        PhotoBrowser.showFromImageView(headerView.imageViewIcon, URLStrings: URLStrings, index: index)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.footerAddRefresh { () -> Void in
            
            NetManager.getReviewsWithBookId(self.book.id, page: self.page, resultClosure: { (result, reviews) -> Void in
                
                if result {
                    let count = self.reviews.count
                    var indexPaths = [NSIndexPath]()
                    for (i, review) in reviews.enumerate() {
                        self.reviews.append(review)
                        indexPaths.append(NSIndexPath(forRow: count+i, inSection: 0))
                    }
                    
                    if indexPaths.isEmpty {
                        self.tableView.footerEndRefreshNoMoreData()
                    } else {
                        self.page++
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.tableView.footerEndRefresh()
                    }
                    
                } else {
                    self.view.makeToast("网络异常，请上拉重试")
                    self.tableView.footerEndRefresh()
                }
                
                
            })
        }
        
        tableView.footerBeginRefresh()
        
    }
    
    
    // MARK: - UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailTableViewCell", forIndexPath: indexPath) as! ReviewCell
        cell.configureWitReview(reviews[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //返回
    @IBAction func back(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
   
    //系统监听旋转的方法
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition(nil) { (context) -> Void in
            PhotoBrowser.reloadForScreenRotate()
        }
    }
    
    
//    - (UIStatusBarStyle)preferredStatusBarStyle
//    {
//    return UIStatusBarStyleDefault;
//    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
//    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
//    }
//    
//    - (BOOL)prefersStatusBarHidden
//    {
//    return YES; // 返回NO表示要显示，返回YES将hiden
//    }
//    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
}



















































