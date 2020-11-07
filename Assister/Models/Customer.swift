//
//  Customer.swift
//  Assister
//
//  Created by Sana on 07/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

class Customer : (Codable & Decodable){
    
    var id : Int?
    var appointments : Array<Consultation>?
    var name : String?
    var email : String?
    
    init(name : String, email : String){
        self.name = name
        self.email = email
    }
    
    
    func getName() -> String?{
        return name
    }
    
    func getEmail() -> String?{
        return email
    }
}
