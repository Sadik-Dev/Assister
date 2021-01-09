//
//  ContactsViewController.swift
//  Assister
//
//  Created by Sana on 11/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var contactsTable: UITableView!
    @IBOutlet weak var addButton: UIImageView!
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var totalOfContacts: UILabel!

    var contacts: [Customer]? = []
    var filteredContacts = [Customer]() {
        didSet {
            self.contactsTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
        initTable()
        initEventHandlers()
    }

    func initEventHandlers() {
        // Option Button
        let tap = UITapGestureRecognizer(target: self, action: #selector(ContactsViewController.openForm(gesture:)))
        addButton?.addGestureRecognizer(tap)
        addButton?.isUserInteractionEnabled = true

        searchBox.addTarget(self, action: #selector(filterTable), for: .editingChanged)

    }

    @objc func filterTable() {
        self.filteredContacts = (self.contacts?.filter {
            contact in
            if searchBox.text!.isEmpty {
                return true
            } else {
                return (contact.getName()?.containsIgnoringCase(find: searchBox.text!))!

            }
            })!

    }

    @objc func openForm(gesture: UIGestureRecognizer) {

           if (gesture.view as? UIImageView) != nil {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PatientVC = storyBoard.instantiateViewController(withIdentifier: "AddPatientViewController") as! AddPatientViewController
           PatientVC.modalPresentationStyle = .fullScreen

           self.present(PatientVC, animated: true, completion: nil)

        }
    }

    func initTable() {

        let rowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 130 : 100
        contactsTable?.rowHeight = CGFloat(rowHeight)

        contactsTable?.dataSource = self
        contactsTable?.delegate = self

        contactsTable.resignFirstResponder()

        // Data
        DataService.shared.getContacts().subscribe {
            elements in
            if let data = elements.element {
                self.contacts = data
                self.filteredContacts = self.contacts!
                self.contactsTable?.reloadData()
                self.totalOfContacts.text = String(data.count)
            }
        }

      }

    func styleViews() {

        // Styling the search box
        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)

        // Style the nextConsultation View
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.1
        todaysConsultationContainer?.layer.shadowRadius = 4.0
        todaysConsultationContainer?.layer.masksToBounds = false

        // Style the add Button
        addButton?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        addButton?.layer.shadowOpacity = 0.1
        addButton?.layer.shadowRadius = 4.0
        addButton?.layer.masksToBounds = false

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredContacts.count
      }
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactsTableViewCell

        // Style the nextConsultation View
        cell.container.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        cell.container.layer.shadowOpacity = 0.1
        cell.container.layer.shadowRadius = 4.0
        cell.container.layer.masksToBounds = false

        let customer = filteredContacts[indexPath.row]

        let customerName = customer.getName()
        cell.cellTitle.text = customerName!

        if customer.getGender() == "female" {

            var image: UIImage = UIImage(named: "female")!

            cell.cellIcon.image = image
        } else {
            var image: UIImage = UIImage(named: "male")!

            cell.cellIcon.image = image
        }

        let c: Int = customer.getConsultations()!.count

        cell.numberOfConsultations.text = String(c)

        // Edit event handler
        cell.editButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.editUser(sender:))))

        cell.editButton?.isUserInteractionEnabled = true

        return cell
    }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = filteredContacts[indexPath.row]

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let patientView = storyBoard.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
        patientView.modalPresentationStyle = .fullScreen
        patientView.patient = customer
        self.present(patientView, animated: true, completion: nil)

     }

    @objc func editUser( sender: UITapGestureRecognizer) {

            // using sender, we can get the point in respect to the table view
            let tapLocation = sender.location(in: self.contactsTable)

            // using the tapLocation, we retrieve the corresponding indexPath
            let indexPath = self.contactsTable.indexPathForRow(at: tapLocation)
            let contact = filteredContacts[indexPath!.row]

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PatientVC = storyBoard.instantiateViewController(withIdentifier: "AddPatientViewController") as! AddPatientViewController
            PatientVC.modalPresentationStyle = .fullScreen
            self.present(PatientVC, animated: true, completion: nil)
            PatientVC.editPatient(patient: contact)

     }

    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
     }

}
