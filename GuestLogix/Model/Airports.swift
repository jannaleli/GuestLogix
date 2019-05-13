//
//  Airports.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import MapKit
import CoreData
import UIKit

struct    Airports: Codable{

    
   
        var name: String
        var city: String?
        var country: String?
        var iata_three: String?
        var latitute: Double?
        var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case city = "City"
        case country = "Country"
        case iata_three = "IATA 3"
        case latitute = "Latitute "
        case longitude = "Longitude"
    }
    
    
   

    
}
