//

import Foundation
import UIKit
import CoreData

class DataService{
    
    //Singleton
    static let shared = DataService()
    

    //Core Data
    
    let appDelegate : AppDelegate
    
    let managedContext : NSManagedObjectContext
              
    var userEntity : NSEntityDescription
    
    var user : NSManagedObject
    
    let ud: UserDefaults = UserDefaults.standard

    //Properties
    


    
   private init(){
    
    // Init Data Core
    
     appDelegate = UIApplication.shared.delegate as! AppDelegate
       
     managedContext = appDelegate.persistentContainer.viewContext
                 
     userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
                 
     user = NSManagedObject(entity: userEntity, insertInto: managedContext)
         

    
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

        print("out", getBearerToken() as Any)

    }
    
    func logout(){
              
        ud.removeObject(forKey: "cookie")

        print("out", getBearerToken() as Any)

    }
   
    
    func getBearerToken() -> String? {
        
        let data = ud.string(forKey: "cookie")
        return data
        
    }
    

    
   
   
    
    
    

}
