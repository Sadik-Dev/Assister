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
    private var birthDate : Date?
    private var password : String?
    private var rijkRegisterNummer : Int64?
  
    init(){
        appointments = []
    }
    func getBirthDateStringified() -> String{
     
     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy-MM-dd HH:mm"

        formatter.timeStyle = .none
     formatter.dateStyle = .full
     formatter.locale = Locale(identifier: "en_BE")
     
     return formatter.string(from: birthDate!)

     
    }
    func getId() -> Int?{
        return id
    }
    func setId(id: Int) {
        self.id = id
    }
    
    func createPatient(name: String, email: String, gender: String, birthdate: Date, password: String, rijkregisternummer: Int64){
        
        setName(name: name)
        setEmail(email: email)
        setGender(gender: gender)
        setBirthDate(birthdate: birthdate)
        setPassword(password: password)
        setRijkRegisterNummer(nummer: rijkregisternummer)
        
    }
    
    func setBirthDate(birthdate: Date){
        self.birthDate = birthdate
    }
    
    func setPassword(password: String){
        self.password = password
    }
    
    func setRijkRegisterNummer(nummer: Int64 ){
        self.rijkRegisterNummer = nummer
    }
    func getRijkRegisterNummer() -> Int64?{
        return rijkRegisterNummer
    }
    func getBirthDate() -> Date?{
        return birthDate
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
    func setConsultations(consultations : [Consultation]){
        
        self.appointments = consultations
    }
}
