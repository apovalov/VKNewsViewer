//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Macbook on 12.10.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit


protocol FeedCellViewModel {
    
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttacmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attacmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttacmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    static let reuseId = "NewsfeedCell"
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none

        
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        iconImageView.set(imageURL: viewModel.iconUrlString)
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attacmentFrame
//        bottomView.frame = viewModel.sizes.bottomViewFrame
//        
//        
//        if let photoAttachment = viewModel.photoAttachment{
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}
