//
//  GroceryItem.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/13/24.
//

import Foundation

// Model for a grocery item
struct GroceryItem: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
    var category: Category
    
    // Enumeration for item categories
    enum Category: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case produce = "Produce"
        case dairy = "Dairy"
        case bakery = "Bakery"
        case meat = "Meat"
        case household = "Household Items"
        case uncategorized = "Uncategorized"
    }
}
