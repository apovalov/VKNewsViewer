//
//  NewsfeedPresenter.swift
//  VKNewsFeed
//
//  Created by Macbook on 11/10/2019.
//  Copyright (c) 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
  
  }
  
}
