//
//  ConfigurationsViewController.swift
//  doei-app
//
//  Created by Max Mendes on 17/05/21.
//

import UIKit

class ConfigurationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.setValue(nil, forKey: "token")
        UserDefaults.standard.setValue(nil, forKey: "userId")
        UserDefaults.standard.setValue(false, forKey: "logado")
        tabBarController?.selectedIndex = 0
    }
    
}
