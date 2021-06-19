//
//  PostsService.swift
//  doei-app
//
//  Created by Max Mendes on 08/05/21.
//

import Foundation
import Alamofire

struct PostsService {
    
    static func getPosts(url: String, params: Parameters, encoding: URLEncoding, completion:@escaping (_ posts: Posts?) -> Void){
        
        print(params)
        
        AF.request(url, method: .get, parameters: params, encoding: encoding).responseJSON { (response) in
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
    
    
    static func getMyPosts(url: String,  params: Parameters, header: HTTPHeaders, encoding: URLEncoding, completion:@escaping (_ posts: MyPostsResponse?) -> Void){
        
        AF.request(url, method: .get, parameters: params, encoding: encoding, headers: header).responseJSON { (response) in
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MyPostsResponse.self, from: data)
                completion(result)
                
            }catch{
                completion(nil)
            }
        }
    }
    
    static func createPost(url: String, params: Parameters, header: HTTPHeaders, encoding: JSONEncoding, completion:@escaping (Bool) -> ()){
        
        AF.request(url, method: .post, parameters: params, encoding: encoding, headers: header).responseJSON { (response) in
            
            if response.response?.statusCode == 200 {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    static func login(url: String, params: Parameters, header: HTTPHeaders, encoding: JSONEncoding, completion:@escaping (_ user: UserResponse?) -> ()){
        
        AF.request(url, method: .post, parameters: params, encoding: encoding, headers: header).responseJSON { (response) in
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(result)
                
            }catch{
                completion(nil)
            }

        }
    }
}
