//
//  UserTableViewController.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/18.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    @IBOutlet weak var imageViewIcon: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelDetail: UILabel!
    
    @IBOutlet weak var labelAlt: UILabel!
    
    @IBOutlet weak var labelCreated: UILabel!
    
    @IBOutlet weak var labelDesc: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewIcon.layer.cornerRadius = 40
        imageViewIcon.layer.masksToBounds = true
        imageViewIcon.sd_setImageWithURL(NSURL(string: User.shareUser.avatar))
//        imageViewIcon.setImageWithURL(User.shareUser.avatar)
        labelName.text = User.shareUser.name
        labelAddress.text = User.shareUser.loc_name
        
        labelDetail.text = User.shareUser.douban_user_id
        labelAlt.text = User.shareUser.alt
        labelCreated.text = User.shareUser.created
        labelDesc.text = User.shareUser.desc
        
        tableView.tableFooterView = UIView()
    }

}
