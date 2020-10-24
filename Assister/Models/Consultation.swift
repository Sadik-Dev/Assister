//
//  Consultation.swift
//  Assister
//
//  Created by Sana on 22/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

class Consultation{
    
    private let dateTime : Date
    
    private let name : String
    
    public init(name : String){
     
      let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss Z"

        dateTime = formatter.date(from: "13-03-2020 13:37:00 +0100")!
        
        self.name = name
        
     
     }
    
    public func getName() -> String{
        return name
    }
    
    public func getDateTime() -> Date{
           return dateTime
       }
}
