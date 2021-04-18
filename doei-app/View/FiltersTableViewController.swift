//
//  FiltersTableViewController.swift
//  doei-app
//
//  Created by Max Mendes on 18/04/21.
//

import UIKit

class FiltersTableViewController: UIViewController {
    
    var type: String?
    var dataSource: [String] = []
    var categories: [String] = ["Eletrônicos","Móveis", "Roupas", "Calçados", "Acessórios"]
    var cities: [String] = ["Porto Alegre","Florianópolis", "São Paulo", "Joinville", "Niterói"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataFilters()
        
        
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDataFilters(){
        if(type ==  "C"){
            self.dataSource = categories
            
        }else{
            self.dataSource = cities
        }
    }
}

extension FiltersTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterTableViewCell
        cell.lblFilter.text = dataSource[indexPath.row]
        
        return cell
    }
    
    
}
