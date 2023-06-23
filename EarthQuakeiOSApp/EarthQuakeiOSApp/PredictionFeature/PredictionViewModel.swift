//
//  PredictionViewModek.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

import Foundation
import Combine
import MapKit

enum APICallStatus {
    case notCalled
    case inProgress
    case received
}

class PredictionViewModel: ObservableObject {
    @Published var predictionList = [PredictionModel]()
    @Published var apiStatus: APICallStatus = .notCalled
    private var cancellable: AnyCancellable?
    
    init() {
        getEarthQuakeList()
    }
    
    func getEarthQuakeList() {
        apiStatus = .inProgress
        let service = EarthquakeService()
        cancellable = RestService.getAPICall(service: service)
            .sink { [weak self] status in
                print(status)
                self?.apiStatus = .received
            } receiveValue: { [weak self] list in
                self?.predictionList = list.earthquakes
            }
    }
    
    func getRegion(for prediction: PredictionModel) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: prediction.lat, longitude: prediction.lng), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
    
    func getCombinedInfo(prediction: PredictionModel) -> String {
        return "Depth: \(prediction.depth) Magnitude: \(prediction.magnitude)"
    }
}
