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
    var patient : Customer?
    
    @IBOutlet weak var noConsultations: UIImageView!
    //Labels
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var rijkRegisterLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initEventHandlers()
        initTable()
        setLabels()
    }
    
    func setLabels(){
        
        fullNameLabel.text = patient?.getName()
        emailLabel.text = patient?.getEmail()
        genderLabel.text = patient?.getGender()
        rijkRegisterLabel.text = patient?.getRijkRegisterNummer()?.description
        birthDateLabel.text  = patient?.getBirthDateStringified()
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
        
        if((patient?.getConsultations()!.count)! > 0){
            noConsultations.isHidden = true
        }
        else{
            noConsultations.isHidden = false
        }
    }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (patient?.getConsultations()!.count)!

      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "consultCell") as! HomeTableViewCell
                
        let customerName = patient?.getName()
        let date = patient?.getConsultations()?[indexPath.row].getDateTimeString()
        let gender = patient?.getGender()
        
        cell.cellTitle.text = "Consultation"
        cell.cellTitle.sizeToFit()
            
        cell.cellSubTitle.text = "On " + date!
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
