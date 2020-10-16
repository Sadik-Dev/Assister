//
//  LoginScreenController.swift
//  Assister
//
//  Created by Sana on 15/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit
class LoginScreenController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFieldsAndButton()
     
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
   
   

    @IBAction func login(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
          
         
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)

           

    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent //.default for black style
    }
    
    func initTextFieldsAndButton(){
        
        let fields = [emailTF, passwordTF]
        
        fields.forEach { field in
            let bottomLine = CALayer()
                          
                          bottomLine.frame = CGRect(x: 0.0, y: emailTF.frame.height - 1, width: emailTF.frame.width, height: 2.0)
                          bottomLine.backgroundColor = UIColor (named:"primary")?.cgColor
            field?.borderStyle = UITextField.BorderStyle.none
            field?.layer.addSublayer(bottomLine)
        }
             
        passwordTF.isSecureTextEntry = true
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
}
