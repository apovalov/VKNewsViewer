//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Macbook on 17.11.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
