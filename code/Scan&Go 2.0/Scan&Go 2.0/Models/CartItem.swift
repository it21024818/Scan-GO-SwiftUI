//
//  CartItem.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/13/24.
//

import Foundation
import SwiftUI

// Model for items in the cart
struct CartItem: Identifiable {
    let id = UUID()
    let image: Image
    let name: String
    let price: Double
    let description: String
    var quantity: Int
}
