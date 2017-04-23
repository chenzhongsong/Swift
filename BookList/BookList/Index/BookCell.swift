//
//  BookCell.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/1.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDetail: UILabel!
    
    @IBOutlet weak var ratingView: UIView!
    
    var book:Book!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureWithBook(book:Book) {
//        imageViewIcon.sd_setImageWithURL(NSURL(string: book.image))
        
        self.book = book
        
        imageViewIcon.setResizeImageWith(book.image, width: imageViewIcon.frame.size.width)
        
        if let rating = book.rating {
            RatingView.showInView(ratingView, value: rating.average)
        } else { //没有
            RatingView.showNoRating(ratingView)
        }
        
        
        labelTitle.text = book.title
        
        var detail = ""
        for str in book.author {
            detail += str + "/"
        }
        labelDetail.text = detail + book.publisher + "/" + book.pubdate
    }

//    - (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    totalHeight += [self.titleLabel sizeThatFits:size].height;
//    totalHeight += [self.contentLabel sizeThatFits:size].height;
//    totalHeight += [self.contentImageView sizeThatFits:size].height;
//    totalHeight += [self.usernameLabel sizeThatFits:size].height;
//    totalHeight += 40; // margins
//    return CGSizeMake(size.width, totalHeight);
//    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        
        var totalHeight:CGFloat = 8
        totalHeight += self.labelTitle.sizeThatFits(size).height + 8
        totalHeight += 15 + 8
        totalHeight += self.labelDetail.sizeThatFits(size).height + 8
        
        return CGSizeMake(size.width, totalHeight)
    }
}













