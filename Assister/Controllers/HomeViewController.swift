import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    
    @IBOutlet  var notificationsTable: UITableView?
    @IBOutlet  var settingsButton: UIImageView?
    @IBOutlet  var consultationsToday: UILabel!
    
    var consultations : Array<Consultation>? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        DataService.shared.getConsultations().subscribe{
            elements in
            if let data = elements.element{
                self.consultations = data
                self.notificationsTable?.reloadData()
                
                //Set Appointments today
                
                var count : Int = 0
                let calendar = Calendar.current

                for c in self.consultations!{
                    
                    let date = c.getDateTime()
                    
                    if calendar.isDateInToday(date){
                        count += 1
                    }
                }
                
                self.consultationsToday?.text = String(count)
                
                
            }
        }
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
        
        logout()
       
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
        if(consultations!.count > 0){
            loadNextConsultationView()
        }
        else{
            loadNoNextConsultationView()
        }
    }
    
    
    func loadNextConsultationView(){
        
        var consultation = consultations?.first
        
        let todaysConsultationContainer =  (self.view.viewWithTag(7) as! RoundedCornerView?)

        //Style the nextConsultation View
        todaysConsultationContainer?.backgroundColor = UIColor(named: "primary")
        todaysConsultationContainer?.layer.shadowColor = UIColor.black.cgColor
        todaysConsultationContainer?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        todaysConsultationContainer?.layer.shadowOpacity = 0.1
        todaysConsultationContainer?.layer.shadowRadius = 4.0
        todaysConsultationContainer?.layer.masksToBounds = false


        //Name of patient
        (self.view.viewWithTag(1) as? UILabel)?.text = consultation?.getCustomer()?.getName()
        
        //Show Consultation label
        (self.view.viewWithTag(3) as? UILabel)?.isHidden = false

        //Time
        
        (self.view.viewWithTag(2) as? UILabel)?.isHidden = false
        (self.view.viewWithTag(2) as? UILabel)?.text = "Consultation at " + (consultation?.getTime())!
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
    
  
    
    func initNotificationsTable(){
        notificationsTable?.dataSource = self
            notificationsTable?.delegate = self
    }
    
    
   func logout() {

        DataService.shared.logout()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let loginScreen = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginScreen)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultations!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell") as! HomeTableViewCell
            
        let customerName = consultations![indexPath.row].getCustomer()?.getName()
        let date = consultations![indexPath.row].getDateTimeString()

    
        cell.cellTitle.text = customerName! + " made an new appointment"
        cell.cellTitle.sizeToFit()
        
        cell.cellSubTitle.text = "Consultation on " + date
        cell.cellSubTitle.sizeToFit()

        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
     }

  
}


