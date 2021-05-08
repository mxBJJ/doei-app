//
//  ViewController.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import UIKit
import Kingfisher

class PostViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var dataSource: Posts?
    var viewModel: PostViewModel?
    var logado = false
    
    
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.60, y: 0.60)

        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        setViewModel()
        setSearchBar()
        
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        setViewModel()
        refreshControl.endRefreshing()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationItem.backButtonTitle = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setViewModel(){
        self.viewModel = PostViewModel()
        self.viewModel?.getPosts(completion: { (posts) in
            self.dataSource = posts!
            self.collectionView.reloadData()
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
    
    
    func setSearchBar(){
        self.searchBar.delegate = self
        self.searchBar.searchTextField.backgroundColor = UIColor.white
        self.searchBar.searchTextField.textColor = UIColor(red: 1/255, green: 102/255, blue: 92/255, alpha:  1)
        self.searchBar.backgroundImage = UIImage()
    }
    
    @IBAction func btnFilterAction(_ sender: Any) {
        
        UserDefaults.standard.setValue("Categorias/Subcategorias", forKey: "categorias")
        UserDefaults.standard.setValue("Cidade", forKey: "cidade")
        
        let filterVC = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController

        let navController = UINavigationController(rootViewController: filterVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    
}

extension PostViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel!.dataSourceSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        
        self.setCellAsCard(cell: cell)
        
        cell.productName.text = dataSource?.posts?[indexPath.row].title
        cell.giverAdress.text = dataSource?.posts?[indexPath.row].location
        cell.productState.text = dataSource?.posts?[indexPath.row].state
        cell.postImage.kf.setImage(with: URL(string: (dataSource?.posts?[indexPath.row].img)!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.post = dataSource?.posts?[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
    
    
}
