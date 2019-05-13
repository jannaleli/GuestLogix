//
//  MapStore.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 12/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import CSV
import SwiftGraph
import CoreData
var airlineRecords: [Airlines] = []

var airportRecords: [Airports] = []

var routesRecords: [Routes] = []

var cityGraph: UnweightedGraph<String>? = nil


class MapStore: MapStoreProtocol {
    
    private var airlineType = Airlines.self
    
    private var airportType = Airports.self
    
    private var routesType = Routes.self

    
    enum Kind {
        
        case airports
        
        case airlines
        
        case routes
        
    }
    
     var state: Kind?
    

  
    func readFromCSV(csvFile: String) -> [AnyObject] {
        
        var genericRecords: [AnyObject] = []
        
        guard let generic = try? String(contentsOfFile: csvFile , encoding: String.Encoding.utf8) else {
            
            return []
            
        }
        
     
        switch state {
            
        case .airports?:
            
            do {
          
                let reader = try CSVReader(string: generic, hasHeaderRow: true)
                
                let decoder = CSVRowDecoder()
          
                while reader.next() != nil {
                    
                    let row = try decoder.decode(airportType, from: reader)
                    
                    genericRecords.append(row as AnyObject)
                    
                }
                
            } catch {
                
                return []
                
            }
            
            return genericRecords
            
        case .routes?:
            do {
  
                let reader = try CSVReader(string: generic, hasHeaderRow: true)
                
                let decoder = CSVRowDecoder()
                
                while reader.next() != nil {
                    
                    let row = try decoder.decode(routesType, from: reader)
                    
                    genericRecords.append(row as AnyObject)
                    
                    
                }
                
            } catch {
                
                return []
                
            }
            
            return genericRecords
            
        case .airlines?:
            
            do {
       
                let reader = try CSVReader(string: generic, hasHeaderRow: true)
                
                let decoder = CSVRowDecoder()
                
                while reader.next() != nil {
                    
                    let row = try decoder.decode(airlineType, from: reader)
                    
                    genericRecords.append(row as AnyObject)
                    
                }
                
            } catch {
                
                return []
                
            }
            
            return genericRecords
            
        default:
            
            break
            
        }
        

        
        return []
        
    }
    
    func loadCityGraph(){
        
        let nonNilElements = airportRecords.compactMap { $0.iata_three }
        
        cityGraph = UnweightedGraph<String>(vertices: nonNilElements)
        
        for each in routesRecords {
            
            cityGraph?.addEdge(from: each.origin, to: each.destination)
            
        }
        
    }
    
    
    
    func loadData() {
        
        guard let airlinePath = Bundle.main.path(forResource: "airlines", ofType: "csv") else {
            
            return
            
        }
        
        self.state = .airlines
        
        airlineRecords = readFromCSV(csvFile: airlinePath) as! [Airlines]
        
        
        guard let airportPath = Bundle.main.path(forResource: "airports", ofType: "csv") else {
            
            return
            
        }
        
        self.state  = .airports
        
        airportRecords = readFromCSV(csvFile: airportPath) as! [Airports]

        guard let routesPath = Bundle.main.path(forResource: "routes", ofType: "csv") else {
            
            return
            
        }
        self.state = .routes
        
        routesRecords = readFromCSV(csvFile: routesPath) as! [Routes]
        

        }
    }

