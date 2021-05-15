//
//  CreatePostViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var categories: [String] = ["Eletrônicos","Móveis", "Roupas", "Calçados", "Acessórios"]
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var txtViewTitle: UITextView!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var txtViewPhone: UITextView!
    
    var imagePicker = UIImagePickerController()

    
    let logado = true
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoView.addDashedBorder()
        
    }
    @IBAction func pickImage(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         picker.dismiss(animated: true, completion: nil)
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             imageView.image = image
         }

     }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.image = nil

        if(!logado){
            tabBarController?.selectedIndex = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        txtViewTitle.text = "Ex: Playstation 4 PRO"
        txtViewTitle.textColor = UIColor.lightGray
        txtViewDescription.text = "Ex: Playstation 4 PRO em excelente estado, acompanha 1 controle e 2 jogos."
        txtViewDescription.textColor = UIColor.lightGray
        txtViewPhone.text = "Ex: (51) 999999-9999"
        txtViewPhone.textColor = UIColor.lightGray
        
        if(!logado){
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .popover
            tabBarController?.present(loginVC, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        txtViewTitle.endEditing(true)
        txtViewDescription.endEditing(true)
        txtViewPhone.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtViewTitle.textColor == UIColor.lightGray  && txtViewTitle.isFirstResponder{
            txtViewTitle.text = nil
            txtViewTitle.textColor = UIColor.black
        }
        
        if txtViewDescription.textColor == UIColor.lightGray && txtViewDescription.isFirstResponder {
            txtViewDescription.text = nil
            txtViewDescription.textColor = UIColor.black
        }
        
        if txtViewPhone.textColor == UIColor.lightGray && txtViewPhone.isFirstResponder {
            txtViewPhone.text = nil
            txtViewPhone.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewTitle.text.isEmpty {
            txtViewTitle.text = "Ex: Playstation 4 PRO"
            txtViewTitle.textColor = UIColor.lightGray
        }
        
        if txtViewDescription.text.isEmpty {
            txtViewDescription.text = "Ex: Playstation 4 PRO em excelente estado, acompanha 1 controle e 2 jogos."
            txtViewDescription.textColor = UIColor.lightGray
        }
        
        if txtViewPhone.text.isEmpty {
            txtViewPhone.text = "Ex: (51) 999999-9999"
            txtViewPhone.textColor = UIColor.lightGray
        }
    }
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor(red: 1/255, green: 102/255, blue: 92/255, alpha:  1).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - 40, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2 - 20, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
}
