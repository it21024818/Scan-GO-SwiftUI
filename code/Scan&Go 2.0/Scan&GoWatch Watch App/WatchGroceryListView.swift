//
//  GroceryListView.swift
//  Scan&GoWatch Watch App
//
//  Created by Dinuka Dissanayake on 6/12/24.
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

struct WatchGroceryListView: View {
    @StateObject private var viewModel = GroceryListViewModel()
    
    var body: some View {
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
                }
            }
        }
        .navigationTitle("Grocery List")
    }
}

struct WatchGroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchGroceryListView()
    }
}

