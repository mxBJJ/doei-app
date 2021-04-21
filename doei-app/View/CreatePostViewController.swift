//
//  CreatePostViewController.swift
//  doei-app
//
//  Created by Max Mendes on 14/04/21.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    let logado = true
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoView.addDashedBorder()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOCOU")
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
