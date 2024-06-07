//
//  Location.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/8/24.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let city: String
    let contactNo: String
    let openingHours: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String 
}
