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


    
   private init(){
    
//    consultation = Consultation(name : "Aziz Low")

    
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
    func login(){
        
        
        ud.set("efewfgew", forKey: "cookie")


    }
    
    func logout(){
              
        ud.removeObject(forKey: "cookie")


    }
   
    
    func getBearerToken() -> String? {
        
        let data = ud.string(forKey: "cookie")
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
