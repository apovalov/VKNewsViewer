//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Macbook on 11/10/2019.
//  Copyright (c) 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    private var revealedPostIds = [Int]()
    private var feedRespone: FeedResponse?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsfeed:
            fetcher.getFeed {  [weak self] (feedResponse) in
                self?.feedRespone = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(let postId):
            revealedPostIds.append(postId)
            presentFeed()
        case .getUser:
            fetcher.getUser { userResponse in
                self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
             print(userResponse)
            }
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = self.feedRespone else { return }
        presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsfeed(feed: feedResponse, revealdedPostIds: revealedPostIds))
    }
}
