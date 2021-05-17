//
//  DetailViewController.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import UIKit
import Kingfisher
import FloatRatingView


class DetailViewController: UIViewController, FloatRatingViewDelegate {
    
    var post: Post?
    @IBOutlet weak var btnWant: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataInViews()
        setViewsStyles()
        ratingView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.backButtonTitle = " "
    }
    
    
    func setDataInViews(){
        
        
        if let myDate = post?.createdAt {
                                    
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: myDate) {
                dateFormatter.dateFormat = "dd/MM/YYYY"
                let finalDate = dateFormatter.string(from: date)
                self.lblDate.text = "Publicado em \(finalDate)"

            }
            
            self.lblTitle.text = post?.title
            self.postImage.kf.setImage(with: URL(string: (post?.img)!))
            self.lblContact.text = post?.user?.phone
            self.lblState.text = post?.state
            self.lblLocation.text = post?.location
            self.lblDescription.text = post?.description
        }
    }
    
    func setViewsStyles(){
        btnWant.layer.cornerRadius = 20
        self.ratingView.rating = (self.post?.user?.rating!)!
        self.ratingView.editable = false
    }
    
    
    @IBAction func btnWantAction(_ sender: Any) {
        
        if let phone = self.post?.user?.phone {
        UIApplication.shared.openURL(URL(string:"https://api.whatsapp.com/send?phone=\(phone)")!)
        }
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
        let items = ["Somente no DoeiApp!",URL(string: "google.com")!] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
    @IBAction func ratingView(_ sender: Any) {
        
        let ratingVC = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        
        present(ratingVC, animated: true, completion: nil)
    }
    
}
