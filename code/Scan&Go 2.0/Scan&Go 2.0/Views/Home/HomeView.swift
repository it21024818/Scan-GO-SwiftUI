//
//  HomeView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI
import CoreLocation

// View for displaying home information and locations
struct HomeView: View {
    
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
            MapView(locations: locations, selectedLocation: $selectedLocation)
                .frame(height: 380)
            
            // Display location details if a location is selected
            if let location = selectedLocation {
                CircleImage(imageName: location.imageName)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title)
                    
                    HStack {
                        Text(location.address)
                        Spacer()
                        Text(location.city)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    Text("Contact No: \(location.contactNo)")
                        .font(.title2)
                        .padding(.bottom, 10)
                    Text("Opening Hours: \(location.openingHours)")
                }
                .padding()
            } else {
                // Display a message if no location is selected
                CircleImage(imageName: "defaultLogo")
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text("Select a location on the map")
                        .font(.title)
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

// Preview provider for HomeView
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
