//
//  PredictionsListView.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

/*
 --
 highlight for magnitude > 8
 show on map
 click on plus icon and present form with all details and submit
 when submitted add it to list
 */

import SwiftUI

struct PredictionsListView: View {
    @StateObject private var predictionVm = PredictionViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(predictionVm.predictionList) { prediction in
                        NavigationLink {
                            PredictionMapView(region: predictionVm.getRegion(for: prediction))
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Occured Date: \(prediction.datetime)")
                                Text("Depth: \(prediction.depth)")
                                Text("Magnitude: \(prediction.magnitude)")
                            }
                        }
                    }
                }
                if predictionVm.apiStatus == .inProgress {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(.thinMaterial)
                }
            }

        }
    }
}

struct PredictionsListView_Previews: PreviewProvider {
    static var previews: some View {
        let prediction = PredictionModel(datetime: "2011-03-11 04:46:23", src: "us", eqid: "c0001xgp", lat: 38.322, lng: 142.369, magnitude: 8.8, depth: 24.4)
        PredictionsListView()
    }
}
