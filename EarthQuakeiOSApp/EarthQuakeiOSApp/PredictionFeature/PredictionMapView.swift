//
//  PredictionMapView.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct PredictionMapView: View {
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .padding(30)
    }
}

struct PredictionMapView_Previews: PreviewProvider {
    static var previews: some View {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        PredictionMapView(region: region)
    }
}
