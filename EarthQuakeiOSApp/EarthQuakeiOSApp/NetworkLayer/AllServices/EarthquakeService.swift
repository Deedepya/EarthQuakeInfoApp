//
//  EarthquakeService.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

import Foundation

struct EarthquakeService: ServiceInput {
    typealias DataModel = PredictionMainModel
    
    var urlStr: String {
        return APIURLs.earthQuakeURL
    }
}
