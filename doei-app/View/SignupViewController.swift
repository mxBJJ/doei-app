//
//  SignupViewController.swift
//  doei-app
//
//  Created by Max Mendes on 19/06/21.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {

    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var passwordConfirmationTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
        self.nameTxtField.endEditing(true)
        self.emailTxtField.endEditing(true)
        self.phoneTxtField.endEditing(true)
        self.passwordTxtField.endEditing(true)
        self.passwordConfirmationTxtField.endEditing(true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        
        if(passwordTxtField.text != passwordConfirmationTxtField.text || passwordTxtField.text == "" && passwordConfirmationTxtField.text == ""){
            let alert = UIAlertController(title: "Senha inválida!", message: "As senhas informadas divergem. Os campos de senha e confirmação precisam ser iguais e não vazios.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if(nameTxtField.text == ""){
            let alert = UIAlertController(title: "Campo não preenchido!", message: "O campo nome precisa ser preenchido.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        if(emailTxtField.text == ""){
            let alert = UIAlertController(title: "Campo não preenchido!", message: "O campo e-mail precisa ser preenchido.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        if(phoneTxtField.text == ""){
            let alert = UIAlertController(title: "Campo não preenchido!", message: "O campo celular/whatsapp precisa ser preenchido.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        var params = Parameters()
        
        params["name"] = nameTxtField.text
        params["email"] = emailTxtField.text
        params["password"] = passwordTxtField.text
        params["phone"] = phoneTxtField.text
        
        let url = API.authUrl + Endpoints.cadastrar.rawValue
        
        PostsService.register(url: url, params: params, encoding: JSONEncoding.default) { response in
            
            print(response)
        }
        
    }
}
