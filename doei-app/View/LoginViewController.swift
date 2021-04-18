//
//  LoginViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var btnGoogle: UIButton!
    
    var logado: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsStyles()
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
        self.txtFieldEmail.endEditing(true)
        self.txtFieldPassword.endEditing(true)
    }
    
    func setViewsStyles(){
        btnFacebook.layer.cornerRadius = 20
        btnGoogle.layer.cornerRadius = 20
    }
    
}
