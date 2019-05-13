//
//  File.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 12/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

protocol InitialProtocol {

     func determineEligibleAirports(sourceText: String, destinationText :String) -> (Bool, [Airports], [Airports])
    
}
