//
//  ConsultationFormViewController.swift
//  Assister
//
//  Created by Sana on 23/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class ConsultationFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
 
    
    
    @IBOutlet weak var closeView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!

    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var deleteBtn: UIImageView!
    @IBOutlet weak var patient: UIPickerView!
    
    var editingConsultation: Bool = false
    var editingConsultationId : Int = 0
    var patients : Array<String>? = []
    var patientsObjects : Array<Customer>? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationFormViewController.close(gesture:)))
                     closeView?.addGestureRecognizer(tap)
                     closeView?.isUserInteractionEnabled = true
        
        
        let deleteTap = UITapGestureRecognizer(target: self, action: #selector(ConsultationFormViewController.deletePatient(gesture:)))
                      deleteBtn?.addGestureRecognizer(deleteTap)
                      deleteBtn?.isUserInteractionEnabled = true
        
        deleteBtn.isHidden = true
    
    }
    @objc func deletePatient(gesture: UIGestureRecognizer){
        
    let alert = UIAlertController(title: "Confirm", message: "Do you want to delete this consultation ?", preferredStyle: .alert)

       alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
        
        let success = DataService.shared.deleteConsultation(id: self.editingConsultationId)
        
            if success{
                //Close the view
                 self.dismiss(animated: true, completion: {
                           self.presentingViewController?.dismiss(animated: true, completion: nil)
                 })
            }
            else{
                // Create new Alert
                var dialogMessage = UIAlertController(title: "Error", message: "Could not delete this patient", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
        }
       }))
    
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                  print("delete canceled")
              }))
    

       self.present(alert, animated: true)
    }
    
   
    @IBAction func createConsultation(_ sender: Any) {
        
        let pString  = patients![patient.selectedRow(inComponent: 0)]
        var patient : Customer? = nil
        if let index = patientsObjects!.firstIndex(where: { $0.getName() ==  pString}) {
            patient = patientsObjects![index]
        }
        
        let consultation = Consultation()
        consultation.createConsultation(date: datePicker.date, customer: patient!)
        
        var success : Bool = false
        
        if editingConsultation{
            consultation.setId(id: editingConsultationId)
            success = DataService.shared.editConsultation(consultation: consultation)

        }
        else {
             success = DataService.shared.createConsultation(consultation: consultation)
        }
        
        if success{
            self.dismiss(animated: true, completion: {
                         self.presentingViewController?.dismiss(animated: true, completion: nil)
                         })
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let calendarvc = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
            
        }
    }
    

    
    func styleViews(){
   
        submitButton.layer.cornerRadius = 18
        submitButton.clipsToBounds = true
        
        //Date Picker
        let now = Date();
        datePicker.minimumDate = now
        
        //Patient Picker
        // Connect data:
        self.patient.delegate = self
        self.patient.dataSource = self
        
        DataService.shared.getContacts().subscribe{
            elements in
                    if let data = elements.element{
                        self.patients = data.map{
                            (p) -> String in
                            p.getName()!
                        }
                        
                        self.patientsObjects = data
            }
        }
        
        
        
      }
    
    func editConsultation(consultation: Consultation){
        styleViews()
           
        datePicker.date = consultation.getDateTime()
        if let index = patientsObjects!.firstIndex(where: { $0.getName() ==  consultation.getCustomer()?.getName()}) {
                  print(index)
            patient.selectRow(index, inComponent: 0, animated: true)
              }
        
        editingConsultation = true
        deleteBtn.isHidden = false
        viewTitle.text = "Edit a consultation"
        editingConsultationId = consultation.getId()!
        
        
        

     }

    @objc func close(gesture: UIGestureRecognizer){
           
          self.dismiss(animated: true, completion: {
              self.presentingViewController?.dismiss(animated: true, completion: nil)
              })
       }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return patients!.count

     }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return patients![row]
    }
}
