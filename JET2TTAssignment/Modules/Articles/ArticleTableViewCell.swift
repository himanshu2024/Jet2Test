//
//  ArticleTableViewCell.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var article : Article?{
        didSet{
            if let article = article{
                userNameLabel.text = article.user?.first?.fullName
                userDesignationLabel.text = article.user?.first?.designation
                articleDescriptionLabel.text = article.content
                articleTitle.text = article.media?.first?.title
                articleUrlLabel.text = article.media?.first?.url
                
                timeLabel.text = Utility.getTimeDifferenceInMin(from: article.createdAt)
                
                commentsLabel.text = Utility.getCommentsString(comments: article.comments)
                
                likesLabel.text = Utility.getLikesString(likes: article.likes)
                
                ImageLoader().imageFromUrl(urlString: article.user?.first?.avatar) { image in
                    self.profileImageView.image = image
                }
                ImageLoader().imageFromUrl(urlString: article.media?.first?.image) { image in
                    if let image = image{
                        self.articleImageView.isHidden = false
                        self.articleImageView.image = image
                    }
                    else{
                        self.articleImageView.isHidden = true
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
