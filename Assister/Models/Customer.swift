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
    
  
    init(){
        appointments = []
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
    
    func setName(name: String){
        self.name = name
    }
    func setGender(gender: String){
        self.gender = gender
    }
    func setEmail(email: String){
        self.email = email
    }
}
