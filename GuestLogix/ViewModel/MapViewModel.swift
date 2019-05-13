//
//  MapViewModel.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 13/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation

class MapViewModel: MapProtocol{
    
    func determineStopovers(origin: Airports, dest: Airports) -> (Bool, [Airports]) {
        var finalDestination: [Airports] = []
        
        let edges = numberOfEdges(origin: origin, dest: dest)
        
        
        if edges.count == 0 {
     
            return (false, [])
        }
        
        for each in edges {
            let airport = airportRecords.filter {
                $0.iata_three == each
            }
            finalDestination.append(airport.first!)
        }

        return (true, finalDestination)
        
    }
    
    
    func numberOfEdges(origin: Airports, dest: Airports) -> [String]  {
        let path =  cityGraph!.bfs(from: (origin.iata_three!), to: dest.iata_three!)
        
        if path.count == 0 {
            
            return []
        }
        
        let edges = cityGraph!.edgesToVertices(edges: path)
        return edges
    }
}
