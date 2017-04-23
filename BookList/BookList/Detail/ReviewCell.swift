//
//  ReviewCell.swift
//  BookList
//
//  Created by chenzs on 16/4/12.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    

    @IBOutlet weak var imageViewHead: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var ratingViewContianer: UIView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelSummary: UILabel!
    
    @IBOutlet weak var labelRatingNum: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWitReview(review:Review) {
        imageViewHead.sd_setImageWithURL(NSURL(string: review.author.avatar))
        labelTitle.text = review.title
        labelName.text = review.author.name
        if let rating = review.rating {
            RatingView.showInView(ratingViewContianer, value: rating.average)
            labelRatingNum.text = Int(rating.numRaters).description
        } else {
            RatingView.showNoRating(ratingViewContianer)
        }
        
        labelSummary.text = review.summary
        labelDate.text = review.updated
        
        
    }

}
































