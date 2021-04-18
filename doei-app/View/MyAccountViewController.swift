//
//  MyAccountViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    
    var logado: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!logado){
            tabBarController?.selectedIndex = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!logado){
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .popover
            tabBarController?.present(loginVC, animated: true, completion: nil)
        }
    }
}
