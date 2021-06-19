//
//  FilterViewController.swift
//  doei-app
//
//  Created by Max Mendes on 17/04/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lblCity: UILabel!
    
    var btnCategoryTitle: String = "Categorias/Subcategorias"
    var btnCityTitle: String = "Cidade"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setViewsLayouts()  {
        navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 102/255, blue: 92/255, alpha:  1)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.backButtonTitle = " "
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        loadLeftBarItem()
        loadRightBarItem()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setViewsLayouts()
        lblCategory.text = UserDefaults.standard.string(forKey: "categorias")
        lblCity.text = UserDefaults.standard.string(forKey: "cidade")
    }
    
    func loadLeftBarItem() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(leftButton))
        self.navigationItem.leftBarButtonItem  = logoutBarButtonItem
    }
    func loadRightBarItem() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Limpar", style: .done, target: self, action: #selector(rightButton))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc private func leftButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func rightButton() {
        
        UserDefaults.standard.setValue("Categorias/Subcategorias", forKey: "categorias")
        UserDefaults.standard.setValue("Cidade", forKey: "cidade")
        
        lblCategory.text = "Categorias/Subcategorias"
        lblCity.text = "Cidade"
    }
    
    
    @IBAction func btnCategoriesAction(_ sender: Any) {
        
        let filtersVC = storyboard?.instantiateViewController(withIdentifier: "FiltersTableViewController") as! FiltersTableViewController
        
        filtersVC.type = "C"
        self.navigationController?.pushViewController(filtersVC, animated: true)
        
    }
    
    
    @IBAction func btnCityAction(_ sender: Any) {
        let filtersVC = storyboard?.instantiateViewController(withIdentifier: "FiltersTableViewController") as! FiltersTableViewController
        
        filtersVC.type = "City"
        self.navigationController?.pushViewController(filtersVC, animated: true)
    }
    @IBAction func filterAction(_ sender: Any) {
        self.dismiss(animated: true) {
            UserDefaults.standard.setValue(self.lblCategory.text, forKey: "categoryFilter")
            UserDefaults.standard.setValue(self.lblCity.text, forKey: "cityFilter")
            UserDefaults.standard.setValue(self.segmentedControl.selectedSegmentIndex, forKey: "orderByFilter")
            
            NotificationCenter.default.post(name: NSNotification.Name("postsLoad"), object: nil)

        }
    }
}
