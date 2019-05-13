//
//  Routes.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct  Routes:Codable {
     var airlineId: String
     var origin: String
     var destination: String
    
    enum CodingKeys: String, CodingKey {
        case airlineId = "Airline Id"
        case origin = "Origin"
        case destination = "Destination"
      
        
    }
    
    // MARK: - Decodable
 

   
}
