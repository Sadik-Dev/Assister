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
    
    var contacts : Array<Customer>? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        initTable()

    }
    
    func initTable(){
        
        let rowHeight = 100
        contactsTable?.rowHeight = CGFloat(rowHeight)
            
        contactsTable?.dataSource = self
        contactsTable?.delegate = self
            
          
        let o = Customer(name: "Oussama Sadik", email: "String", gender: "Male")
    
        let x = Customer(name: "Xena Oporisto", email: "String", gender: "Female")
        
        contacts?.append(o)
        contacts?.append(x)

          
      }

    func styleViews(){
        
        //Styling the search box
        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)

        //Style the nextConsultation View
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.1
        todaysConsultationContainer?.layer.shadowRadius = 4.0
        todaysConsultationContainer?.layer.masksToBounds = false
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
        
        if (customer.getGender() == "Female") {
            
            var image: UIImage = UIImage(named: "female")!

            cell.cellIcon.image = image
        }
        else{
            var image: UIImage = UIImage(named: "male")!

            cell.cellIcon.image = image
        }
        
        let amount = customer.getConsultations()?.count
        cell.numberOfConsultations.text =
            String(amount!)
        
        
        
       

        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
     }


}
