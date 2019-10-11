//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Macbook on 10/10/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
