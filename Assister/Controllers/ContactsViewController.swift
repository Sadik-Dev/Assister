//
//  ContactsViewController.swift
//  Assister
//
//  Created by Sana on 11/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var contactsTable: UITableView!
    
    @IBOutlet weak var addButton: UIImageView!
    var contacts : Array<Customer>? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews()
        initTable()
        initEventHandlers()
    }
    
    func initEventHandlers(){
        //Option Button
        let tap = UITapGestureRecognizer(target: self, action: #selector(ContactsViewController.openForm(gesture:)))
        addButton?.addGestureRecognizer(tap)
        addButton?.isUserInteractionEnabled = true
    }
    
    @objc func openForm(gesture: UIGestureRecognizer){
        
           if (gesture.view as? UIImageView) != nil {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let SettingsViewController = storyBoard.instantiateViewController(withIdentifier: "AddPatientViewController") as! AddPatientViewController
           SettingsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
           self.present(SettingsViewController, animated: true, completion: nil)
            
        }
    }
    
    func initTable(){
        
        let rowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 130 : 100
        contactsTable?.rowHeight = CGFloat(rowHeight)
            
        contactsTable?.dataSource = self
        contactsTable?.delegate = self
            
          
//        //Data
//        DataService.shared.getContacts().subscribe{
//            elements in
//            if let data = elements.element{
//                self.contacts = data
//                self.contactsTable?.reloadData()
//            }
//        }
        
        let contact = Customer()
        contact.setEmail(email: "dsk0@live.fr")
        contact.setName(name: "Oussama")
        contact.setGender(gender: "male")
        
        contacts?.append(contact)
          
      }

    func styleViews(){
        
        //Styling the search box
        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)

        //Style the nextConsultation View
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.1
        todaysConsultationContainer?.layer.shadowRadius = 4.0
        todaysConsultationContainer?.layer.masksToBounds = false
        
        //Style the add Button
        addButton?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        addButton?.layer.shadowOpacity = 0.1
        addButton?.layer.shadowRadius = 4.0
        addButton?.layer.masksToBounds = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return contacts!.count
      }
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
 

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactsTableViewCell
        
        //Style the nextConsultation View
        cell.container.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cell.container.layer.shadowOpacity = 0.1
        cell.container.layer.shadowRadius = 4.0
        cell.container.layer.masksToBounds = false
        
        let customer = contacts![indexPath.row]
        
        let customerName = customer.getName()
        cell.cellTitle.text = customerName!
        
        if (customer.getGender() == "female") {
            
            var image: UIImage = UIImage(named: "female")!

            cell.cellIcon.image = image
        }
        else{
            var image: UIImage = UIImage(named: "male")!

            cell.cellIcon.image = image
        }
        
        let c : Int = customer.getConsultations()!.count
        
        cell.numberOfConsultations.text = String(c)
        
//        let amount = customer.getConsultations()?.count
//        cell.numberOfConsultations.text =
//            String(amount!)
        
        
        
       

        return cell
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let patientView = storyBoard.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
        patientView.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                          
        self.present(patientView, animated: true, completion: nil)
            
     }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
     }


}
