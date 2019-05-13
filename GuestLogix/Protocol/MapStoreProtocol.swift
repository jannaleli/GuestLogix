//
//  MapStoreProtocol.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 12/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
protocol MapStoreProtocol {
    func readFromCSV(csvFile: String) -> [AnyObject] 
    func loadCityGraph()
    func loadData()
}
