//
//  Customer.swift
//  Assister
//
//  Created by Sana on 07/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

class Customer : (Codable & Decodable){
    
    private var id : Int?
    private var appointments : Array<Consultation>?
    private var name : String?
    private var email : String?
    private var gender : String?
    
    init(name : String, email : String, gender: String? = "Male", appointments: [Consultation]? = []){
        
        self.gender = gender
        self.name = name
        self.email = email
        self.appointments = appointments
        
        
    }
    
    func getGender() -> String?{
        return gender
    }
    
    func getName() -> String?{
        return name
    }
    
    func getEmail() -> String?{
        return email
    }
    
    func getConsultations() -> [Consultation]?{
        return appointments
    }
}
