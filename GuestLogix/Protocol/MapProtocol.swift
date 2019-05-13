//
//  MapProtocol.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 12/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

protocol MapProtocol {

    func determineStopovers(origin: Airports, dest: Airports) -> (Bool, [Airports]) 
    
}
