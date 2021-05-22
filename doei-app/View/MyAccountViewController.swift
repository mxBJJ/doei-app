//
//  MyAccountViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit

class MyTapGesture: UITapGestureRecognizer {
    var position = 0
}

class MyAccountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var logado: Bool = false
    var viewModel: MyPostsViewModel?
    var dataSource: MyPostsResponse?
    var selectedItem: Int?
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    @objc func loadList(notification: NSNotification) {
        setViewModel()
    }
    
    func setViewModel(){
        self.loadingView.isHidden = false
        self.viewModel = MyPostsViewModel()
        self.viewModel?.getMyPosts(completion: { (posts) in
            self.dataSource = posts!
            self.collectionView.reloadData()
            self.loadingView.isHidden = true
        })
    }
    
    
    func setCellAsCard(cell: UICollectionViewCell){
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myPostCell", for: indexPath) as! MyPostsCollectionViewCell
        
        setCellAsCard(cell: cell)
        
        cell.index = indexPath.row
        cell.postId = (dataSource?.posts?[indexPath.row]._id)!
        cell.productName.text = dataSource?.posts?[indexPath.row].title
        cell.productLocation.text = dataSource?.posts?[indexPath.row].location
        cell.productState.text = dataSource?.posts?[indexPath.row].state
        cell.imageUrl = (dataSource?.posts?[indexPath.row].img)!
        cell.productImage.kf.setImage(with: URL(string: (dataSource?.posts?[indexPath.row].img)!))
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let logado = UserDefaults.standard.bool(forKey: "logado")
        
        if(!logado){
            tabBarController?.selectedIndex = 0
        }else {
            setViewModel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let logado = UserDefaults.standard.bool(forKey: "logado")
        
        if(!logado){
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .popover
            tabBarController?.present(loginVC, animated: true, completion: nil)
        }
    }
}
