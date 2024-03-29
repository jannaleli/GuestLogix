//
//  GuestLogixTests.swift
//  GuestLogixTests
//
//  Created by Jann Aleli Zaplan on 11/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import XCTest
@testable import GuestLogix
@testable import SwiftGraph

class GuestLogixTests: XCTestCase {
    
    var mapProtocol: MapProtocol = MapViewModel()
    
    var initialProtocol: InitialProtocol = InitialViewModel()
    
    var airlinePath: String = ""
    
    var mapLoadProtocol: MapStoreProtocol = MapStore()
    
    override func setUp() {
        
        mapLoadProtocol = MapStore()
        
        mapLoadProtocol.state = .airlines
        
        airlinePath = Bundle.main.path(forResource: "airlines", ofType: "csv")!
        

    }
    override func tearDown() {
        
        mapLoadProtocol = nil
        
        mapProtocol = nil
        
        initialProtocol = nil
        
        super.tearDown()
        
    }

    func testMapStore() {
       
        let airlineRecords = mapLoadProtocol.readFromCSV(csvFile: airlinePath)
        
        XCTAssertNotEqual(airlineRecords.count, 0, "")
        

    }

    func testEligibleAirports() {
        
        let result = initialProtocol.determineEligibleAirports(sourceText: "Random", destinationText: "Random2")
        
         XCTAssertNotEqual(result, true, "")
        
    }
    
   
    func testStopovers(){
        
        let airport1 = Airports.init(name: "Random", city: "", country: "", iata_three: "AAA", latitute: 0.0, longitude: 0.0)
        
        let result = mapProtocol.determineStopovers(origin: airport1, dest: airport1)
        
        XCTAssertNotEqual(result, true, "")
        
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
          
        }
    }

}
