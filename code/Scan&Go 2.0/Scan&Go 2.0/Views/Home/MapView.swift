//
//  MapView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/7/24.
//

//import SwiftUI
//import MapKit
//
//struct MapView: View {
//    var body: some View {
//        Map(initialPosition: .region(region))
//    }
//
//    private var region: MKCoordinateRegion {
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 6.882728996369276, longitude: 79.93445813475586),
//            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//        )
//    }
//}
//
//#Preview {
//    MapView()
//}

import SwiftUI
import MapKit

struct MapView: View {
    let locations: [Location]
    @Binding var selectedLocation: Location?
    
    var body: some View {
        Map(coordinateRegion: .constant(region), annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Button(action: {
                    selectedLocation = location
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            }
        }
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 6.882728996369276, longitude: 79.93445813475586),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}
