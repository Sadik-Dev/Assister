//
//  AddPatientViewController.swift
//  Assister
//
//  Created by Sana on 13/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class AddPatientViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rijksRegisterTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTextFieldsAndButton()
    }
    
      func initTextFieldsAndButton(){
            
            let fields = [emailTF, passwordTF,nameTF,rijksRegisterTF]

            fields.forEach { field in
            
            field?.setBottomBorder()
            }
         
            passwordTF.isSecureTextEntry = true
            
            submitButton.layer.cornerRadius = 18
            submitButton.clipsToBounds = true
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
