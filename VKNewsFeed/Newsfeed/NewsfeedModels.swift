//
//  NewsfeedModels.swift
//  VKNewsFeed
//
//  Created by Macbook on 11/10/2019.
//  Copyright (c) 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsfeed
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsfeed (feed: FeedResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttacmentViewModel?
        var sizes: FeedCellSizes
    }

    struct FeedCellPhotoAttachment: FeedCellPhotoAttacmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}
