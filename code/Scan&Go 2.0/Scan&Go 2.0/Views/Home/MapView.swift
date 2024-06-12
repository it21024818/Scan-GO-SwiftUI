//
//  MapView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/7/24.
//

import SwiftUI
import MapKit

// View for displaying a map with locations
struct MapView: View {
    
    // Array of locations
    let locations: [Location]
    
    // Binding to track the selected location
    @Binding var selectedLocation: Location?
    
    var body: some View {
        // Map view displaying annotations for each location
        Map(coordinateRegion: .constant(region), annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                // Button to select a location when tapped
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
    
    // Region of the map to be displayed
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 6.882728996369276, longitude: 79.93445813475586),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}
