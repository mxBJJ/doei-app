//
//  CreatePostViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit
import Alamofire
import FirebaseStorage

class CreatePostViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var loadingView: UIView!
    var categories: [String] = ["Eletrônicos","Móveis", "Roupas", "Calçados", "Acessórios"]
    var cities: [String] = ["Porto Alegre","Florianópolis", "São Paulo", "Joinville", "Niterói"]
    var productState: [String] = ["Com defeito","Regular", "Bom", "Novo"]
    
    @IBOutlet weak var pickerViewProductState: UIPickerView!
    @IBOutlet weak var pickerViewCategory: UIPickerView!
    @IBOutlet weak var pickerViewCity: UIPickerView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var txtViewTitle: UITextView!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var txtViewPhone: UITextView!
    
    var imagePicker = UIImagePickerController()
    
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
    
        let logado = UserDefaults.standard.bool(forKey: "logado")
        
        if(!logado){
            tabBarController?.selectedIndex = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let logado = UserDefaults.standard.bool(forKey: "logado")
        
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
    
    @IBAction func createPost(_ sender: Any) {
        
        loadingView.isHidden = false
        
        let strBase64 = imageView.image?.jpegData(compressionQuality: 1)?.base64EncodedString()
        
        if let title = txtViewTitle.text{
            if let postDescription = txtViewDescription.text {
                if let contact = txtViewPhone.text {
                    var post = PostEntity()
                    post.title = title
                    post.description = postDescription
                    post.contact = contact
                    post.img = strBase64
                    post.location = cities[pickerViewCity.selectedRow(inComponent: 0)]
                    post.state = productState[pickerViewProductState.selectedRow(inComponent: 0)]
                    post.category = categories[pickerViewProductState.selectedRow(inComponent: 0)]
                    post.user = "60908cd96181b817f3ac363c"
                    
                    createPost(postEntity: post)

                }
            }
        }
        
    }
    
    
    
    func createPost(postEntity: PostEntity){
        
        
        var params = Parameters()
        var header = HTTPHeaders()
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOTA4Y2Q5NjE4MWI4MTdmM2FjMzYzYyIsImlhdCI6MTYyMTI2MjE3MCwiZXhwIjoxNjIxMzQ4NTcwfQ.d9iaUKv0INSxr0CTJU0ji6NKlpk6lK6Qb-PHTvNrsiM"
        
        header = [
             "Authorization": "Bearer \(token)",
             "Content-Type": "application/json"
         ]
        
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        let storageRef = Storage.storage().reference(forURL: "gs://doeiapp-9d5a9.appspot.com")
        
        let postImageRef = storageRef.child("images").child(UUID().uuidString)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        postImageRef.putData(imageData, metadata: metadata) { storageData, error in
            if(error != nil){
                print("Image upload error")
                return
            }
            
            postImageRef.downloadURL { url, error in
                if let metadataUrl = url?.absoluteString{
                    print(metadataUrl)
                    params["img"] = metadataUrl
                    params["title"] = postEntity.title
                    params["description"] = postEntity.description
                    params["location"] = postEntity.location
                    params["contact"] = postEntity.contact
                    params["state"] = postEntity.state
                    params["user"] = postEntity.user
                    
                    
                    let url = API.baseUrl + Endpoints.posts.rawValue
                    
                    PostsService.createPost(url: url, params: params, header: header, encoding: JSONEncoding.default) { [self] (completion) in
                        
                        if completion{
                            loadingView.isHidden = true
                            print("Anuncio criado ok!")
                            let confirmAlert = UIAlertController(title: "Parabéns", message: "Seu anúncio foi publicado!", preferredStyle: UIAlertController.Style.alert)
                            
                            confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            }))
                            
                            self.present(confirmAlert, animated: true, completion: nil)
                            
                            
                        }else{
                            print("POST criar anuncio error!")
                            let errorAlert = UIAlertController(title: "Erro", message: "Erro ao criar anúncio!", preferredStyle: UIAlertController.Style.alert)
                            
                            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            }))
                            
                            self.present(errorAlert, animated: true, completion: nil)
                            
                        }
                    }

                }
            }
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
        if(pickerView == pickerViewCity){
            return cities.count
        }
        
        if(pickerView == pickerViewProductState){
            return productState.count
        }
        
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerViewCity){
            return cities[row]
        }
        
        if(pickerView == pickerViewProductState){
            return productState[row]
        }
        
        return categories[row]
    }
    
}
