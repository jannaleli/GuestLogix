//
//  Airlines.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
struct Airlines:  Codable {
    
    
    var name: String
  var twoDigitCodes: String
   var threeDigitCodes: String
   var country: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case twoDigitCodes = "2 Digit Code"
        case threeDigitCodes = "3 Digit Code"
        case country = "Country"

    }
    

    


}
public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
