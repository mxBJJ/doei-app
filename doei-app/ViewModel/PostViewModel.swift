//
//  PostViewModel.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import Foundation

class PostViewModel {
    
    var dataSource:Posts?
    
    func getPosts(completion:@escaping (Posts?) -> Void) {
        
        let url = API.baseUrl + Endpoints.posts.rawValue
        
        PostsService.getPosts(url: url) { (result) in
            
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
