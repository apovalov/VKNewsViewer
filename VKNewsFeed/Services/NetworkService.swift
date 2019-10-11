//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Macbook on 08/10/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String:String], completion: @escaping (Data?, Error?) -> Void)
}


//https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.101

final class NetworkService: Networking {
    
    
    func request(path: String, params: [String : String],  completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        let params = ["filters": "post, photo"]
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService){
        self.authService = authService
    }
    
    private func createDataTask(from request: URLRequest,  completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
)    }

    
    
    private func url(from path: String, params: [String : String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        print(params)
        components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        
        return components.url!
    }
    
    
}
