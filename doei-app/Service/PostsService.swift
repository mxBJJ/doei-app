//
//  PostsService.swift
//  doei-app
//
//  Created by Max Mendes on 08/05/21.
//

import Foundation
import Alamofire

struct PostsService {
    
    static func getPosts(url: String, completion:@escaping (_ posts: Posts?) -> Void){
        
        AF.request(url, method: .get).responseJSON { (response) in
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Posts.self, from: data)
                completion(result)
                
            }catch{
                completion(nil)
            }
        }
    }
}
