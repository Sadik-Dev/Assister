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
    @IBOutlet weak var closeView: UIImageView!
    
    @IBOutlet weak var fullNameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var birthError: UILabel!
    @IBOutlet weak var rijkRegisterNummerError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    @IBOutlet weak var segmentGender: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTextFieldsAndButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPatientViewController.close(gesture:)))
               closeView?.addGestureRecognizer(tap)
               closeView?.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
              view.addGestureRecognizer(tap2)
        
    }
    
    @objc func handleTap() {
        let fields = [emailTF, passwordTF, rijksRegisterTF, nameTF]

               fields.forEach { field in
               
                field!.resignFirstResponder()

        }
       }
    
    @IBAction func createPatient(_ sender: Any) {
        
        var flag = false
        let fullname = nameTF.text

        if fullname?.range(of: "[a-zA-Z]* [a-zA-Z]*", options: .regularExpression, range: nil, locale: nil) == nil {
            fullNameError.isHidden = false
            fullNameError.shake()
            flag = true
        }
        else{
            fullNameError.isHidden = true

        }
        
        let email = emailTF.text
        if email?.range(of: "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression, range: nil, locale: nil) == nil {
            
            emailError.isHidden = false
            fullNameError.shake()
            flag = true

        }
        else{
            emailError.isHidden = true

        }
        
        let password = passwordTF.text
        if password!.isEmpty {
                 
            passwordError.isHidden = false
            passwordError.shake()
            flag = true

             }
             else{
                 passwordError.isHidden = true

             }
        
        let rijkregisterNummer = rijksRegisterTF.text
        if rijkregisterNummer?.range(of: "[0-9]{11}", options: .regularExpression, range: nil, locale: nil) == nil {
                   
                   rijkRegisterNummerError.isHidden = false
                   rijkRegisterNummerError.shake()
            flag = true

               }
               else{
                   rijkRegisterNummerError.isHidden = true

               }
        
        // Date
        var dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy/MM/dd'T'HH:mm:ss"
        let birthdate = dateFormatter.string(from: birthDatePicker.date)
        
        let gender = segmentGender.titleForSegment(at: segmentGender.selectedSegmentIndex)
        
        if(!flag){
            print("valid")
        }
            
    }
    @objc func close(gesture: UIGestureRecognizer){
         
        self.dismiss(animated: true, completion: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
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
