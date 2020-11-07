//
//  Consultation.swift
//  Assister
//
//  Created by Sana on 22/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

class Consultation : (Codable & Decodable){
    
    private var id : Int?
    private var date : Date?
    private var customer : Customer?
    private var type : String?
    
    
 
    init(id : Int, customer : Customer, type : String){
        
        self.id = id
        self.customer = customer
        self.type = type
        
    }
    func getDateTimeString() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        formatter.timeStyle = .short
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_BE")
        
        return formatter.string(from: date!)

        
       }
    
    func getTime() -> String{
         
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm"

         formatter.timeStyle = .short
         formatter.dateStyle = .none
         formatter.locale = Locale(identifier: "en_BE")
         
         return formatter.string(from: date!)

         
        }
    func getDateTime() -> Date
    {
        return date!
    }
    
    func getCustomer() -> Customer?{
        return customer
    }
    
    func getType() -> String?{
        return type
    }
    
    
}
