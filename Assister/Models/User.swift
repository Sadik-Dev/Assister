//
//  User.swift
//  Assister
//
//  Created by Sana on 04/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

class User: (Codable & Decodable) {

    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var token: String?

    init (name: String, email: String, password: String, token: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.token = token
    }

    func getName() -> String? {
        return self.name
    }

    func getBearer() -> String? {
        return self.token
    }

}

