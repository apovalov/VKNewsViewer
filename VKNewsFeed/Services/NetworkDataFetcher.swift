//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Macbook on 11/10/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping(FeedResponse?) -> Void)
    func getUser(response: @escaping(UserResponse?) -> Void)
    
}
struct NetworkDataFetcher: DataFetcher {
    
    
    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        print(userId)
        let params = ["fields": "photo_100", "user_ids": userId]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                     print("Error received requesting data: \(error.localizedDescription)")
                     response(nil)
                 }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        
        var params = ["filters": "post, photo"]
        
        params["start_from"] = nextBatchFrom
        
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
