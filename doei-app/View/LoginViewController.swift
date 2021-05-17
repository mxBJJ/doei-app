//
//  LoginViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var loadingView: UIView!
        
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
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        loadingView.isHidden = false
        var params = Parameters()
        var header = HTTPHeaders()
        
        header = [
             "Content-Type": "application/json"
         ]
        
        params["email"] = txtFieldEmail.text
        params["password"] = txtFieldPassword.text
        
        let url = API.authUrl + Endpoints.login.rawValue
        
        PostsService.login(url: url, params: params, header: header, encoding: JSONEncoding.default) { [self] user in
            
            if user?.user != nil{
                loadingView.isHidden = true
                print("Usuário logado!")
                UserDefaults.standard.setValue(user?.token, forKey: "token")
                UserDefaults.standard.setValue(true, forKey: "logado")
                UserDefaults.standard.setValue(user?.user?._id, forKey: "userId")

                self.dismiss(animated: true, completion: nil)
            }else{
                print("Falha no login!")
                let errorAlert = UIAlertController(title: "Erro", message: "Erro ao efetuar login!", preferredStyle: UIAlertController.Style.alert)
                
                errorAlert.addAction(UIAlertAction(title: "Entendi", style: .default, handler: { (action: UIAlertAction!) in
                    
                    loadingView.isHidden = true
                }))
                
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
}
