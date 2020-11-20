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
    
    var modifyPatient = false
    var idOfPatient = 0
    
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
        
        var password = passwordTF.text
        if password!.isEmpty {
            
            if modifyPatient{
                password = ""
            }
            else{
                passwordError.isHidden = false
                passwordError.shake()
                flag = true

            }
                 
           
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
        let birthdate = birthDatePicker.date

        let gender = segmentGender.titleForSegment(at: segmentGender.selectedSegmentIndex)
        
        if(!flag){
            
            let patient = Customer()
            patient.createPatient(name: fullname!, email: email!, gender: gender!, birthdate: birthdate, password: password!, rijkregisternummer: Int64(rijkregisterNummer!)!)
            patient.setId(id: idOfPatient)
            
            var succes : Bool
            if modifyPatient{
              succes = DataService.shared.modifyPatient(patient: patient)
            }
            else{
              succes = DataService.shared.createPatient(patient: patient)
            }
            
            
            if(succes){
                
                    self.dismiss(animated: true, completion: {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                    })
            }
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
    
    func editPatient(patient: Customer){
        
        nameTF.text = patient.getName()
        emailTF.text = patient.getEmail()
        rijksRegisterTF.text = patient.getRijkRegisterNummer()?.description
        birthDatePicker.date = patient.getBirthDate()!

        let i = segmentGender.titleForSegment(at: 0)
        if i == patient.getGender(){
            segmentGender.selectedSegmentIndex = 0
        }
        else{
            segmentGender.selectedSegmentIndex = 1
        }
        
        modifyPatient = true
        idOfPatient = patient.getId()!
    }

}

