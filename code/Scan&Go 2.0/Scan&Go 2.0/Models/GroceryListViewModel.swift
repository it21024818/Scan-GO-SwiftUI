//
//  GroceryListViewModel.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 6/13/24.
//

import Foundation


// View model to manage grocery items
class GroceryListViewModel: ObservableObject {
    @Published var items: [GroceryItem] = []
    
    // Add a new item to the list
    func addItem(name: String, category: GroceryItem.Category) {
        let newItem = GroceryItem(name: name, category: category)
        items.append(newItem)
    }
    
    // Delete items at specified indices
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // Move items from source indices to destination index
    func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    // Toggle completion state of an item
    func toggleCompletion(of item: GroceryItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}
