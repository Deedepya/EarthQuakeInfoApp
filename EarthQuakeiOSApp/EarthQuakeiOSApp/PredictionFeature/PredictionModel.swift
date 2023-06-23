//
//  PredictionModel.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

import Foundation


struct PredictionModel: Codable, Identifiable, Hashable {
    let id = UUID()
    let datetime: String
    let src, eqid: String
    let lat, lng: Double
    let magnitude, depth: Double
}

struct PredictionMainModel: Codable {
    let earthquakes: [PredictionModel]
}
