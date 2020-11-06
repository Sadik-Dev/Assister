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
    
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var roundedContainer: RoundedCornerView!
    
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
          
        let loginSucces = DataService.shared.login(email: emailTF.text!,password: passwordTF.text!)

        if(loginSucces){
            loginErrorMessage.isHidden = true
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: loginErrorMessage.center.x - 10, y: loginErrorMessage.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: loginErrorMessage.center.x + 10, y: loginErrorMessage.center.y))

        loginErrorMessage.layer.add(animation, forKey: "position")
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            
        }
        else{
            loginErrorMessage.isHidden = false
        }

           

    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent //.default for black style
    }
    
    func initTextFieldsAndButton(){
        
        let fields = [emailTF, passwordTF]

        fields.forEach { field in
        
        field?.setBottomBorder()
        field?.frame.size.width = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 300 : 500

        }
        
//         emailTF.centerXAnchor.constraint(equalTo: roundedContainer.centerXAnchor).isActive = true
//        passwordTF.centerXAnchor.constraint(equalTo: roundedContainer.centerXAnchor).isActive = true
             
        passwordTF.isSecureTextEntry = true
        
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
    }
    

    
}
