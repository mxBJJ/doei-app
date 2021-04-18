//
//  RatingViewController.swift
//  doei-app
//
//  Created by Max Mendes on 18/04/21.
//

import UIKit
import FloatRatingView

class RatingViewController: UIViewController, FloatRatingViewDelegate {
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var lblRating: UILabel!
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
