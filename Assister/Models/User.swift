//
//  User.swift
//  Assister
//
//  Created by Sana on 04/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

 class User{
    var name : String?
    var email : String?
    
    func Name(name:String, email:String){
        self.name = name
        self.email = email
    }
    
    func getName() -> String?{
        return self.name
    }
}
