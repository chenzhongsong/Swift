//
//  PhotoBrowserCell.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/14.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class PhotoBrowserCell: UICollectionViewCell, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
