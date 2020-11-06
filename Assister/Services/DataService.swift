//

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
    //Networking
    
    private var networking : HttpRequests

    
   private init(){
    
//    consultation = Consultation(name : "Aziz Low")
    
    networking = HttpRequests()
    
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
        
        let credentials = User(name: "", email: email, password: password)
        let user = networking.login(controller: RequestController.Users, object: credentials)
        print(user?.getName())
        if(user == nil){
            return false
        }
        else{
            self.loggedInUser = user
            ud.set(user?.getBearer(), forKey: "bearer")
            return true
        }


    }
    
    func logout(){
              
        ud.removeObject(forKey: "bearer")
        


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
