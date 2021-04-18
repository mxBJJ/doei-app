//
//  FilterViewController.swift
//  doei-app
//
//  Created by Max Mendes on 17/04/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsLayouts()
        
    }
    
    
    func setViewsLayouts()  {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.backButtonTitle = " "
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCategoriesAction(_ sender: Any) {
        
        let filtersVC = storyboard?.instantiateViewController(withIdentifier: "FiltersTableViewController") as! FiltersTableViewController
        
        filtersVC.type = "C"
        
        present(filtersVC, animated: true, completion: nil)
    }
    
    
    @IBAction func btnCityAction(_ sender: Any) {
        let filtersVC = storyboard?.instantiateViewController(withIdentifier: "FiltersTableViewController") as! FiltersTableViewController
        
        filtersVC.type = "City"
        
        present(filtersVC, animated: true, completion: nil)
    }
    
}
