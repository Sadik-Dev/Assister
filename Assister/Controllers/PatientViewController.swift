//
//  PatientViewController.swift
//  Assister
//
//  Created by Sana on 19/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class PatientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  

    @IBOutlet weak var consultationsTable: UITableView!
    
    @IBOutlet weak var closeView: UIImageView!
    
    var consultations : Array<Consultation>? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initEventHandlers()
        initTable()
 
    }
    
    func initEventHandlers(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PatientViewController.close(gesture:)))
                closeView?.addGestureRecognizer(tap)
            closeView?.isUserInteractionEnabled = true
    }
    
    @objc func close(gesture: UIGestureRecognizer){
            
           self.dismiss(animated: true, completion: {
               self.presentingViewController?.dismiss(animated: true, completion: nil)
               })
        }

    func initTable(){
        
        consultationsTable?.dataSource = self
        consultationsTable?.delegate = self
        let contact = Customer()
        contact.setEmail(email: "dsk0@live.fr")
        contact.setName(name: "Oussama")
        contact.setGender(gender: "male")
                 
        let consultation = Consultation()
                 
        consultation.setDate(date: Date())
        consultation.setCustomer(customer: contact)
                 
        consultations?.append(consultation)
        consultationsTable.reloadData()
              
    }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return consultations!.count

      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "consultCell") as! HomeTableViewCell
                
            let customerName = consultations![indexPath.row].getCustomer()?.getName()
            let date = consultations![indexPath.row].getDateTimeString()
            let gender = consultations![indexPath.row].getCustomer()?.getGender()
        
            cell.cellTitle.text = customerName! + " made an new appointment"
            cell.cellTitle.sizeToFit()
            
            cell.cellSubTitle.text = "Consultation on " + date
            cell.cellSubTitle.sizeToFit()
            
            if (gender == "female") {
                     
                     var image: UIImage = UIImage(named: "female")!

                     cell.cellIcon.image = image
            }
            else{
                     var image: UIImage = UIImage(named: "male")!

                     cell.cellIcon.image = image
            }
                 

            return cell
      }
      

}
