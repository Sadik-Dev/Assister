//
//  ConsultationFormViewController.swift
//  Assister
//
//  Created by Sana on 23/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class ConsultationFormViewController: UIViewController {
    
    @IBOutlet weak var closeView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateError: UILabel!

    @IBOutlet weak var patient: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationFormViewController.close(gesture:)))
                     closeView?.addGestureRecognizer(tap)
                     closeView?.isUserInteractionEnabled = true
    
    }
    
    func styleViews(){
   
        submitButton.layer.cornerRadius = 18
        submitButton.clipsToBounds = true
        
      }

    @objc func close(gesture: UIGestureRecognizer){
           
          self.dismiss(animated: true, completion: {
              self.presentingViewController?.dismiss(animated: true, completion: nil)
              })
       }
  

}
