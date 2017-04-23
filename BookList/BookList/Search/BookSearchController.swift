//
//  BookSearchController.swift
//  BookList
//
//  Created by chenzs on 16/4/7.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class BookSearchController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Propery -
    weak var bookController:ViewController!
    var searchController : UISearchController!  //替换var searchController = UISearchController()
    let SearchPlaceholder = "搜索图书"
    var searchTitles = [String]()
    
    //MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        searchController = UISearchController(searchResultsController: self)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = SearchPlaceholder
        searchController.searchBar.tintColor = UIColor.whiteColor()//取消按钮颜色
        searchController.searchBar.subviews[0].subviews[0].removeFromSuperview()
        
    }
    
    //MARK: - UISearchResultsUpdating 代理 -
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //每次触发searchBar或searchBar内容改变的时候 都会触发
        
        if let tag = searchController.searchBar.text?.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet()) where !tag.isEmpty {
            
            NetManager.getBookTitles(tag, page: 0, resultClosure: { (titles) -> Void in
                self.searchTitles = titles
                self.tableView.reloadData()
                
            })
        }
        
    }
    
    //MARK: - UITableView -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTitles.count
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return 44
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = searchTitles[indexPath.row]
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        searchController.active = false
        bookController.tag = searchTitles[indexPath.row]
        bookController.tableView.headerBeginRefresh()
    }

}


































