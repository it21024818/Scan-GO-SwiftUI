//
//  GroceryListView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI

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

// View for displaying and managing the grocery list
struct GroceryListView: View {
    @StateObject private var viewModel = GroceryListViewModel()
    @State private var isAddingItem = false

    var body: some View {
        NavigationView {
            List {
                ForEach(GroceryItem.Category.allCases) { category in
                    Section(header: Text(category.rawValue)) {
                        ForEach(viewModel.items.filter { $0.category == category }) { item in
                            // Display grocery item with completion status
                            HStack {
                                Text(item.name)
                                Spacer()
                                if item.isCompleted {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.toggleCompletion(of: item)
                            }
                        }
                        .onDelete(perform: viewModel.deleteItems)
                        .onMove(perform: viewModel.moveItems)
                    }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                // Add edit button for rearranging items
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                // Add button to initiate adding new item
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isAddingItem = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // Present sheet for adding new item
            .sheet(isPresented: $isAddingItem) {
                AddItemView(viewModel: viewModel, isAddingItem: $isAddingItem)
            }
        }
    }
}

// View for adding a new item to the grocery list
struct AddItemView: View {
    @ObservedObject var viewModel: GroceryListViewModel
    @Binding var isAddingItem: Bool
    @State private var newItemName: String = ""
    @State private var selectedCategory: GroceryItem.Category = .uncategorized
    
    var body: some View {
        NavigationView {
            Form {
                // Text field for entering item name
                TextField("Item Name", text: $newItemName)
                // Picker for selecting item category
                Picker("Category", selection: $selectedCategory) {
                    ForEach(GroceryItem.Category.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                // Button to save new item
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addItem(name: newItemName, category: selectedCategory)
                        isAddingItem = false
                    }
                }
                // Button to cancel adding new item
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isAddingItem = false
                    }
                }
            }
        }
    }
}

// Preview for GroceryListView
struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
