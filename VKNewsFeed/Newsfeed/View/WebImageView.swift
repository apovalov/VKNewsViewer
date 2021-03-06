//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Macbook on 06.11.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
        return  }
    
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            // from cache
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        // from internet
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}
