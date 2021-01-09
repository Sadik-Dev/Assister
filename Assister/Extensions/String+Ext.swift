//
//  String+Ext.swift
//  Assister
//
//  Created by Sana on 18/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }

    func contains(find: String) -> Bool {
           return self.range(of: find) != nil
       }
       func containsIgnoringCase(find: String) -> Bool {
           return self.range(of: find, options: .caseInsensitive) != nil
       }
}
