//
//  MyPostsViewModel.swift
//  doei-app
//
//  Created by Max Mendes on 22/05/21.
//

import Foundation
import Alamofire

class MyPostsViewModel {
    
    var dataSource : MyPostsResponse?
    var token: String = ""
    var userId: String = ""
    
    
    func getMyPosts(completion:@escaping (MyPostsResponse?) -> Void) {
        
        let url = API.baseUrl + Endpoints.postsByUser.rawValue
        
        var params = Parameters()
        var header = HTTPHeaders()
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            
            self.token = token
        }
        
        if let id = UserDefaults.standard.string(forKey: "userId") {
            
            self.userId = id
        }
        
        params = [
            "userId": userId
        ]

        header = [
             "Authorization": "Bearer \(token)",
             "Content-Type": "application/json"
         ]
        
        
        PostsService.getMyPosts(url: url, params: params, header: header, encoding: URLEncoding.queryString) { (result) in
            
            guard let posts = result else {
                print("Request failed")
                completion(nil)
                return
            }
            
            self.dataSource = posts
            if let dataSource = self.dataSource {
                completion(dataSource)
            }
        }
        
    }
    
    func dataSourceSize() -> Int {
        return dataSource?.posts?.count ?? 0
    }
    
}
