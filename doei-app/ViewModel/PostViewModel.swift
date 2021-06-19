//
//  PostViewModel.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import Foundation
import Alamofire

class PostViewModel {
    
    var dataSource:Posts?
    
    func getPosts(category: String, city: String, order: Int, completion:@escaping (Posts?) -> Void) {
        
        var params = Parameters()

        params["category"] = category
        params["city"] = city
        params["orderBy"] = order
        
        let url = API.baseUrl + Endpoints.posts.rawValue
        
        PostsService.getPosts(url: url, params: params, encoding: URLEncoding.queryString) { (result) in
            
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
