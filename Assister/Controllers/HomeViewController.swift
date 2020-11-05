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
    @IBOutlet  var settingsButton: UIImageView?
    
    
    var consultation : Consultation?
    let notifications = ["Oussama", "Azia", "Lisa", "Yumi","Azura","Yoka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        initEventHandlers()
        initTable()
        checkNextConsutation()
        initNotificationsTable()
    }
    
    @objc func openSettings(gesture: UIGestureRecognizer) {
       
//        if (gesture.view as? UIImageView) != nil {
//          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//          let SettingsViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//            SettingsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//
//                  self.present(SettingsViewController, animated: true, completion: nil)
//
//
//        }
        
        changeConsultations()
    }
    
    func initEventHandlers(){
        
        //Option Button
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.openSettings(gesture:)))
        settingsButton?.addGestureRecognizer(tap)
        settingsButton?.isUserInteractionEnabled = true
    }
    func initTable(){
        let rowHeight = 90
        notificationsTable?.rowHeight = CGFloat(rowHeight)
        
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
        
        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)

        //Style the nextConsultation View
        todaysConsultationContainer?.backgroundColor = UIColor(named: "primary")
        todaysConsultationContainer?.layer.shadowColor = UIColor.black.cgColor
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.1
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
       


    }
    
    func loadNoNextConsultationView(){
        
//        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)
//        
//        //Style the view
//        todaysConsultationContainer?.backgroundColor = UIColor(named: "secondary")
        
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
        


    }
    
    func changeConsultations() {
        
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
        
    
        cell.cellTitle.text = customerName + " made an new appointment"
        cell.cellTitle.sizeToFit()
        
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
     }

  
}


