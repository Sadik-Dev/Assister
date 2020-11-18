//

import RxSwift
import Foundation
import UIKit

class DataService{
    
    //Singleton
    static let shared = DataService()
    
    
    //Cached Data
    let ud: UserDefaults = UserDefaults.standard

    //Properties
    
    private var consultation : Consultation?
    private var loggedInUser : User?
    private var consultations = BehaviorSubject<Array<Consultation>>(value: [])
    private var contacts = BehaviorSubject<Array<Customer>>(value: [])
    private var amountOfContacts : Int?
    private var timer : Timer?
    private var amountOfNotifs : Int?
    
    private var isOnline : Bool = true

    //Networking
    
    private var networking : HttpRequests

    
   private init(){
        
    networking = HttpRequests()
    isOnline = false
    if isUserLoggedIn(){
        initData()
        }
    }
    
    func initData(){
        
        if isOnline {
            networking.setBearer(token: getBearerToken()!)
            
            let newConsultations = networking.getArray(controller: .Consultations, object: Consultation())!
            amountOfNotifs = newConsultations.count
            consultations.onNext(newConsultations)
            
            let newContacts = networking.getArray(controller: .Customers, object: Customer())!
            amountOfContacts = newContacts.count
            contacts.onNext(newContacts)
            
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.checkIfUpToDate), userInfo: nil, repeats: true)
                  
        }
        else{
            let consultations = Array<Consultation>()
            self.consultations.onNext(consultations)

        }
        

    }
    
    
    func updateData(){
        
        setNotification(title: "You have new Notifications")
        var flagForce = false;
        
        let newConsultations = networking.getArray(controller: .Consultations, object: Consultation())!
        if newConsultations.count != amountOfNotifs! {
            amountOfNotifs = newConsultations.count
            consultations.onNext(newConsultations)
            flagForce = true
        }
        
        let newContacts = networking.getArray(controller: .Customers, object: Customer())!
        if newContacts.count != amountOfContacts! || flagForce {
                   amountOfContacts = newContacts.count
                   contacts.onNext(newContacts)
               }
        
        

    }
    
    func setNotification(title : String) -> Void {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        manager.addNotification(title: title)
        manager.scheduleNotifications()
    }

    @objc func checkIfUpToDate()
    {
        let isAppUpToDate = networking.isUserUpToDate()
        
        if !isAppUpToDate {
            updateData()
        }
    }
    
    func getConsultations() -> Observable<Array<Consultation>>{
        return consultations
    }
    
    func getContacts() -> Observable<Array<Customer>>{
        return contacts
    }
    
    //Check if user is logged in
    //By checking if a jwt bearer key is registred
     func isUserLoggedIn() -> Bool {
        
        if getBearerToken() != nil{
            return true
        }
        else {
            return false
        }
        
    }
    
    
    //
    func login(email : String , password : String) -> Bool{
        
        if(isOnline){
            let credentials = User(name: "", email: email, password: password)
            let user = networking.login(controller: RequestController.Users, object: credentials)
            if(user == nil){
                return false
            }
            else{
                self.loggedInUser = user
                ud.set(user?.getBearer(), forKey: "bearer")
                initData()
                return true
            }
        }
        
        else{
            ud.set("offline", forKey: "bearer")
            initData()
            return true
        }
        


    }
    
    func logout(){
              
        ud.removeObject(forKey: "bearer")
        timer?.invalidate()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

             let loginScreen = storyboard.instantiateViewController(identifier: "LoginNavigationController")

             (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginScreen)


    }
   
    
    func getBearerToken() -> String? {
        
        let data = ud.string(forKey: "bearer")
        return data
        
    }
    
    func hasConsultationToday() -> Bool{
        if(consultation != nil){
            return true
        }
        else{
            return false
        }
    }
    
    func getConsultation() -> Consultation?{
        return consultation
    }
    
    
    func setConsultation(consul : Consultation?){
        self.consultation = consul
        
    }
    
  
   
   
    
    
    

}
