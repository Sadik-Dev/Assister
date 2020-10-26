//
//  FirstViewController.swift
//  Assister
//
//  Created by Sana on 15/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    
    @IBOutlet  var notificationsTable: UITableView?
    @IBOutlet var todaysConsultationContainer: UIView?
    
    var consultation : Consultation?
    let notifications = ["Oussama", "Azia", "Lisa", "Yumi","Azura","Yoka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rowHeight = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 90 : 130
        notificationsTable?.rowHeight = CGFloat(rowHeight)
        
        checkNextConsutation()
        initNotificationsTable()
    }
    
    func checkNextConsutation(){
        if(DataService.shared.hasConsultationToday()){
            loadNextConsultationView()
        }
        else{
            loadNoNextConsultationView()
        }
    }
    
    
    func loadNextConsultationView(){
        consultation = DataService.shared.getConsultation()
        
        //Style the view
        todaysConsultationContainer?.backgroundColor = UIColor(named: "primary")
        todaysConsultationContainer?.layer.shadowColor = UIColor.black.cgColor
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.2
        todaysConsultationContainer?.layer.shadowRadius = 4.0
        todaysConsultationContainer?.layer.masksToBounds = false


        //Name of patient
        (self.view.viewWithTag(1) as? UILabel)?.text = consultation?.getName()
        
        //Show Consultation label
        (self.view.viewWithTag(3) as? UILabel)?.isHidden = false

        //Time
        let hour = Calendar.current.component(.hour, from: (consultation?.getDateTime())!)
        let minutes =  Calendar.current.component(.hour, from: (consultation?.getDateTime())!)
        
        (self.view.viewWithTag(2) as? UILabel)?.isHidden = false
        (self.view.viewWithTag(2) as? UILabel)?.text = "Consultation at " + String(hour) + ":" + String(minutes)
        (self.view.viewWithTag(2) as? UILabel)?.sizeToFit()

        //Image
        (self.view.viewWithTag(5) as? UIImageView)?.image = UIImage(named: "male")

        //Clock icons
        (self.view.viewWithTag(6) as? UIImageView)?.isHidden = false
        (self.view.viewWithTag(7) as? UIImageView)?.isHidden = false


    }
    
    func loadNoNextConsultationView(){
        
        //Style the view
        todaysConsultationContainer?.backgroundColor = UIColor(named: "secondary")
        (self.view.viewWithTag(1) as? UILabel)?.text = "No scheduling for the moment"
        (self.view.viewWithTag(1) as? UILabel)?.sizeToFit()
        
        //Time Label
        (self.view.viewWithTag(2) as? UILabel)?.isHidden = true
        
        //Consultation Label
        (self.view.viewWithTag(3) as? UILabel)?.isHidden = true
        
        //Image
        (self.view.viewWithTag(5) as? UIImageView)?.image = UIImage(named: "no-scheduling")
        
        //Clock icons
        (self.view.viewWithTag(6) as? UIImageView)?.isHidden = true
        (self.view.viewWithTag(7) as? UIImageView)?.isHidden = true


    }
    
    @IBAction func button(_ sender: Any) {
        
        if(self.consultation == nil){
            DataService.shared.setConsultation(consul: Consultation(name: "Sadikske Ouss"))
            self.consultation = DataService.shared.getConsultation()
        }
        else{
            DataService.shared.setConsultation(consul: nil)
            self.consultation = DataService.shared.getConsultation()

        }
        
        checkNextConsutation()
    }
    
    func initNotificationsTable(){
        notificationsTable?.dataSource = self
            notificationsTable?.delegate = self
    }
    
    
//    @IBAction func logout(_ sender: Any) {
//
//        DataService.shared.logout()
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let loginScreen = storyboard.instantiateViewController(identifier: "LoginNavigationController")
//
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginScreen)
//
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return notifications.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell") as! HomeTableViewCell
            
        let customerName = notifications[indexPath.row]
        
        cell.cellTitle.text = customerName + " has made an appointment"
        cell.cellTitle.sizeToFit()
        
        return cell
    }
    
  
}


