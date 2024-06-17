//
//  WatchHomeView.swift
//  Scan&GoWatch Watch App
//
//  Created by Dinuka Dissanayake on 6/12/24.
//

import SwiftUI
import CoreLocation
import MapKit

// View for displaying home information and locations in a watchOS app
struct WatchHomeView: View {
    
    // State to track the selected location
    @State private var selectedLocation: Location? = nil
    
    // Array of locations
    let locations: [Location] = [
        Location(name: "SPAR Supermarket", address: "Pannipitiya Road, Battaramulla", city: "Colombo", contactNo: "0115 007 200", openingHours: "Monday - Sunday, 7am - 11pm", coordinate: CLLocationCoordinate2D(latitude: 6.882728996369276, longitude: 79.93445813475586), imageName: "sparLogo"),
        Location(name: "Keells Supermarket", address: "Kotte Road, Nugegoda", city: "Colombo", contactNo: "0112 894 000", openingHours: "Monday - Sunday, 8am - 10pm", coordinate: CLLocationCoordinate2D(latitude: 6.872193, longitude: 79.899267), imageName: "keellsLogo")
    ]
    
    var body: some View {
        VStack {
            // Map view displaying locations
            WatchMapView(locations: locations, selectedLocation: $selectedLocation)
                .frame(height: 150) // Smaller height for watchOS
            
            // Display location details if a location is selected
            if let location = selectedLocation {
//                WatchCircleImage(imageName: location.imageName)
//                    .frame(width: 100, height: 100) // Smaller size for watchOS
//                    .padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    
                    Text(location.address)
                        .font(.caption)
                    Text(location.city)
                        .font(.caption)
                    
//                    Divider()
//                    
//                    Text("Contact: \(location.contactNo)")
//                        .font(.caption)
//                    Text("Hours: \(location.openingHours)")
//                        .font(.caption)
                }
                .padding(.bottom, 10)
                .frame(height: 100)
            } else {
                // Display a message if no location is selected
//                WatchCircleImage(imageName: "defaultLogo")
//                    .frame(width: 100, height: 100) // Smaller size for watchOS
//                    .padding(.bottom, 10)
                
                Text("Select a location on the map")
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
        }
    }
}

// View for displaying a map with locations in a watchOS app
struct WatchMapView: View {
    
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
                        .font(.title2) // Adjusted for watchOS
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

// View for displaying an image within a circle with a shadow in a watchOS app
struct WatchCircleImage: View {
    
    // Name of the image
    var imageName: String
    
    var body: some View {
        // Image view within a resizable circle shape
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100) // Smaller size for watchOS
            .clipShape(Circle()) // Clip the image into a circle shape
            .overlay {
                // Overlay a white circle stroke
                Circle().stroke(.white, lineWidth: 2) // Smaller stroke for watchOS
            }
            .shadow(radius: 5) // Adjusted shadow for watchOS
    }
}

// Preview provider for WatchHomeView in watchOS
struct WatchHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WatchHomeView()
    }
}
