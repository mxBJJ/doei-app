//
//  RatingViewController.swift
//  doei-app
//
//  Created by Max Mendes on 18/04/21.
//

import UIKit
import FloatRatingView
import Alamofire

class RatingViewController: UIViewController, FloatRatingViewDelegate {
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var lblRating: UILabel!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.delegate = self
        ratingView.rating = 3
        lblRating.text = "Bom"
        // Do any additional setup after loading the view.
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        switch rating {
        case 1.0:
            lblRating.text = "Ruim"
        case 2.0:
            lblRating.text = "Razoável"
        case 3.0:
            lblRating.text = "Bom"
        case 4.0:
            lblRating.text = "Ótimo"
        case 5.0:
            lblRating.text = "Excelente"
            
        default:
            lblRating.text = "Bom"
        }
    }
    
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnRating(_ sender: Any) {
        
        
        var params = Parameters()
        
        params["email"] = email
        params["ratingValue"] = ratingView.rating
        
        let url = API.authUrl + Endpoints.avaliar.rawValue

        
        PostsService.rating(url: url, params: params, encoding: JSONEncoding.default) { success in
            
            print(success)
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
