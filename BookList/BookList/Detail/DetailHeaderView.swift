//
//  DetailHeaderView.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/12.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    
    var tableView:UITableView!
    var book:Book!
    
    weak var vc:DetailViewController!
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var imageViewIcon: UIImageView!
   
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var ratingViewContainer: UIView!
    
    @IBOutlet weak var labelRateNum: UILabel!
    
    @IBOutlet weak var labelPublisher: UILabel!
    
    
    @IBAction func comment(sender: AnyObject) {
        
        if User.shareUser.isLogin {
            
        } else {
            vc.navigationController?.pushViewController(UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController"), animated: true)
        }
        
    }
    
    
    @IBAction func collect(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet weak var labelSummary: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    
    
    static func showInVC(vc:DetailViewController) -> DetailHeaderView {
        
        let headerView = NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: nil, options: nil)[0] as! DetailHeaderView
        headerView.configureWith(vc.tableView, book: vc.book)
        headerView.imageViewIcon.addGestureRecognizer(UITapGestureRecognizer(target:vc, action:"showImage:"))
        vc.headerView = headerView
        headerView.vc = vc
        return headerView
        
    }
    
    
    func configureWith(tabeleView:UITableView, book:Book) {
        self.tableView = tabeleView
        self.book = book
        
        imageViewIcon.sd_setImageWithURL(NSURL(string: book.image))
        labelName.text = book.title
        if let rating = book.rating {
            RatingView.showInView(ratingViewContainer, value: rating.average)
            labelRateNum.text = "\(rating.numRaters)人评分"
        } else {
            RatingView.showNoRating(ratingViewContainer)
        }
        
        var desc = ""
        for str in book.author {
            desc += (str + "/")
        }
        
        labelPublisher.text = desc + book.publisher + "/" + book.pubdate
        labelSummary.text = book.summary
        
        tabeleView.tableHeaderView = self
    }
    
    //注意这个函数的调用
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = containerView.frame.size.height
        self.tableView.tableHeaderView = self
    }
    
    
}











































