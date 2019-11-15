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
    var moreTextButtonFrame: CGRect
    var attacmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}




protocol  FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttacmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)) {
        self.screenWidth = screenWidth
    }
    
    
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttacmentViewModel?, isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: Работа с postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
                
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }

            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Работа с moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        //MARK: Работа с attachmentFrame
        
        let attachmmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
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
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attacmentFrame: attacmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
        
    }
}


