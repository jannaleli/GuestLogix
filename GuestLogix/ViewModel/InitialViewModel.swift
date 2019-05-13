//
//  InitialViewModel.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 13/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

class InitialViewModel: InitialProtocol {
    
    func determineEligibleAirports(sourceText: String, destinationText :String) -> (Bool, [Airports], [Airports]) {
        
        let destination = airportRecords.filter {
            
            $0.name == destinationText
            
        }

        let sorurce = airportRecords.filter {
            
            $0.name == sourceText
            
        }
        
        if sorurce.count == 0 || destination.count == 0 {
            
            let message = "No Source or Destiantion Exists."
    
            return (false, [], [])
            
        }
        
        return (true, sorurce, destination)
        
        
    }
    
}
