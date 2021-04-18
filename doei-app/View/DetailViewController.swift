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
    
    @IBOutlet weak var postImage: UIImageView!
    
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
        self.lblTitle.text = post?.title
        self.lblState.text = post?.state
        self.postImage.kf.setImage(with: URL(string: (post?.imgUrl)!))
        
    }
    
    func setViewsStyles(){
        btnWant.layer.cornerRadius = 20
        self.ratingView.rating = 2.5
        self.ratingView.editable = false
    }
    
    
    @IBAction func btnWantAction(_ sender: Any) {
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
        let items = ["Somente no DoeiApp!",URL(string: (post?.imgUrl)!)!] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        print("click")
    }
    
    
    @IBAction func ratingView(_ sender: Any) {
        
        let ratingVC = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        
        present(ratingVC, animated: true, completion: nil)
    }
    
}
