//
//  NewsfeedCellLayerCalculator.swift
//  VKNewsFeed
//
//  Created by Macbook on 07.11.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attacmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}




protocol  FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttacmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)) {
        self.screenWidth = screenWidth
    }
    

    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttacmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
        //MARK: Работа с postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left, y: Constants.postLabelInserts.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Работа с attachmentFrame
        
        let attachmmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : postLabelFrame.maxY + Constants.postLabelInserts.bottom
        
        var attacmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmmentTop),
                                    size: CGSize.zero)
        
        if let attachment = photoAttachment{
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            attacmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
                
        //MARK: Работа с bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attacmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                         attacmentFrame: attacmentFrame,
                         bottomViewFrame: bottomViewFrame,
                         totalHeight: totalHeight)

    }
}


