//
//  ViewController.swift
//  BookList
//
//  Created by chenzhongsong on 16/3/31.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    let identifierBookCell = "BookCell"
    var page = 0//当前页码
    
    let KeyBooks = "books"
    let pageSize = 10 //每页数量
    let URLString = "https://api.douban.com/v2/book/search"
    
    var tag = "Swift"
    var books = [Book]()
    
    var searchController:BookSearchController!
    
    @IBOutlet weak var buttonUser: UIButton!
    
    @IBAction func buttonUser(sender: AnyObject) {
        
        if User.shareUser.isLogin {
            
            
            navigationController?.pushViewController(UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("UserContainerViewController"), animated: true)
            
            
        } else {
            self.view.window?.makeToast("您还未登陆，请登录!")
            navigationController?.pushViewController(UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController"), animated: true)
        }
        
    }
    // MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    // MARK: - life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        buttonUser.layer.cornerRadius = 16
//        buttonUser.layer.masksToBounds = true
//        self.automaticallyAdjustsScrollViewInsets = true;
        
        addMJHeaderAndFooter()//添加上下拉控件
        tableView.headerBeginRefresh()//进来就开始刷新
        // iOS8 自动计算行高
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        //设置searchBar
        searchController = storyboard?.instantiateViewControllerWithIdentifier("BookSearchController") as! BookSearchController
        searchController.bookController = self
        searchView.addSubview(searchController.searchController.searchBar)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateUserInfo", name: NetManager.NotificationUserInfo, object: nil)
               
    }
    
    override func viewWillAppear(animated: Bool) {
        updateUserInfo()
    }
    
    func updateUserInfo() {
        
        if User.shareUser.isLogin {
            if !User.shareUser.avatar.isEmpty {
                buttonUser.sd_setBackgroundImageWithURL(NSURL(string: User.shareUser.avatar), forState: .Normal)
            } else {
                NetManager.getUserInfo()
            }
        }
    }
    
    //横屏  竖屏  frame改变时调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchController.searchController.searchBar.frame = searchView.bounds
    }
    
    // MARK: - UITableView -
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let bookCell = tableView.dequeueReusableCellWithIdentifier(identifierBookCell,forIndexPath: indexPath) as! BookCell
        bookCell.fd_enforceFrameLayout = false;
        bookCell.configureWithBook(books[indexPath.row])
        
        return bookCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.book = books[indexPath.row]
        
        detailController.index = indexPath.row
        detailController.URLStrings = books.map({ (book) -> String in
            return book.images["large"] ?? ""
        })
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableView.fd_heightForCellWithIdentifier(identifierBookCell, cacheByIndexPath: indexPath, configuration: { (cell) -> Void in
            let cell = cell as! BookCell
            cell.fd_enforceFrameLayout = false;
            cell.configureWithBook(self.books[indexPath.row])
        })
    }
    
    // MARK: - MJRefresh -
    private func addMJHeaderAndFooter() {
        
        tableView.headerAddMJRefresh { () -> Void in
            
            self.tableView.footerResetNoMoreData()
            
            
            NetManager.getBooks(self.tag, page: 0, resultClosure: { (result, books) -> Void in
                
                self.tableView.headerEndRefresh()
                
                if result {
                    self.page = 1
                    self.books = books
                    self.tableView.reloadData()
                    
                } else {
                    self.view.makeToast("请求网络失败")
                }
                
            })
            
            /*
            NetManager.GET(self.URLString, parameters: ["tag":self.tag,"start":0,"count":self.pageSize], showHUD: false, success: { (responseObject) -> Void in
                
                    self.books = []  //先清零
                    if let dict = responseObject as? [String:NSObject],
                        array = dict[self.KeyBooks] as? [[String:NSObject]] {
                            
                            for dict in array {
                                self.books.append(Book(dict: dict))
                            }
                            self.page = 1
                            self.tableView.reloadData()
                            
                    }
                    
                    self.tableView.headerEndRefresh()
                
                }) { (error) -> Void in
                    print(error)
                    
                    self.tableView.headerEndRefresh()
            }
            */

            
        }

        
        tableView.footerAddRefresh { () -> Void in
            

            NetManager.getBooks(self.tag, page: self.page, resultClosure: { (result, books) -> Void in
                

                
                    if result {
                        var indexPaths = [NSIndexPath]()
                        let count = self.books.count
                        for (i,book) in books.enumerate() {  //???enumerate的功能
                            self.books.append(book)
                            indexPaths.append(NSIndexPath(forRow: count + i, inSection: 0))
                        }
                        
                        if indexPaths.isEmpty {
                            self.tableView.footerEndRefreshNoMoreData()
                        } else {
                            self.page++
                            self.tableView.footerEndRefresh()
                            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                        }
                        
                        
                    } else {
                        self.tableView.footerEndRefresh()
                        self.view.makeToast("请求网络失败")
                    }


            })
        
            
            /*
            NetManager.GET(self.URLString, parameters: ["tag":self.tag,"start":self.page * self.pageSize,"count":self.pageSize], showHUD: false, success: { (responseObject) -> Void in
                
                    var indexPaths = [NSIndexPath]()
                    if let dict = responseObject as? [String:NSObject],
                        array = dict[self.KeyBooks] as? [[String:NSObject]] {
                            
                            let count = self.books.count
                            for (i,dict) in array.enumerate() {  //???enumerate的功能
                                self.books.append(Book(dict: dict))
                                indexPaths.append(NSIndexPath(forRow: count + i, inSection: 0))
                            }
                            
                    }
                    
                    if indexPaths.isEmpty {
                        self.tableView.footerEndRefreshNoMoreData()
                    } else {
                        self.page++
                        self.tableView.footerEndRefresh()
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                
                
                
                }) { (error) -> Void in
                    print(error)
                    
                    self.tableView.footerEndRefresh()
            }
            */
            
            
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




























































