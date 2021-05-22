//
//  MyPostsCollectionViewCell.swift
//  doei-app
//
//  Created by Max Mendes on 22/05/21.
//

import UIKit
import Alamofire
import FirebaseStorage

class MyPostsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productState: UILabel!
    @IBOutlet weak var productLocation: UILabel!
    
    var index: Int?
    var postId: String = ""
    var token: String = ""
    var imageUrl: String = ""
    
    override class func awakeFromNib() {
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        if let index = index {
            print(index)
            print(postId)
            
            let url = API.baseUrl + Endpoints.posts.rawValue + "/"  + postId
            
            var params = Parameters()
            var header = HTTPHeaders()
            
            if let token = UserDefaults.standard.string(forKey: "token") {
                
                self.token = token
            }
            
            
            params = [
                "postId": self.postId
            ]

            header = [
                 "Authorization": "Bearer \(token)",
                 "Content-Type": "application/json"
             ]
            
            
            
            AF.request(url, method: .delete, headers: header).responseJSON { [self] (response) in
                guard let data = response.data else {
                    print("Cant delete")
                    return
                }
                
                print("deleted")
                
                NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)

            }
        }
    }
    
}
