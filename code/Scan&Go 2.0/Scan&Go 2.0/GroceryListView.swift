//
//  GroceryListView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI

struct GroceryItem: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
    var category: Category
    
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

class GroceryListViewModel: ObservableObject {
    @Published var items: [GroceryItem] = []
    
    func addItem(name: String, category: GroceryItem.Category) {
        let newItem = GroceryItem(name: name, category: category)
        items.append(newItem)
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleCompletion(of item: GroceryItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}

struct GroceryListView: View {
    @StateObject private var viewModel = GroceryListViewModel()
    @State private var isAddingItem = false
    @State private var newItemName: String = ""
    @State private var selectedCategory: GroceryItem.Category = .uncategorized
    
    var body: some View {
        NavigationView {
            List {
                ForEach(GroceryItem.Category.allCases) { category in
                    Section(header: Text(category.rawValue)) {
                        ForEach(viewModel.items.filter { $0.category == category }) { item in
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isAddingItem = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingItem) {
                AddItemView(viewModel: viewModel, isAddingItem: $isAddingItem)
            }
        }
    }
}

struct AddItemView: View {
    @ObservedObject var viewModel: GroceryListViewModel
    @Binding var isAddingItem: Bool
    @State private var newItemName: String = ""
    @State private var selectedCategory: GroceryItem.Category = .uncategorized
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $newItemName)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(GroceryItem.Category.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addItem(name: newItemName, category: selectedCategory)
                        isAddingItem = false
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isAddingItem = false
                    }
                }
            }
        }
    }
}

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
