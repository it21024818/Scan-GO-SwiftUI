//
//  GroceryListView.swift
//  Scan&GoWatch Watch App
//
//  Created by Dinuka Dissanayake on 6/12/24.
//

import SwiftUI
import WatchKit

// View for displaying and managing the grocery list
struct WatchGroceryListView: View {
    @StateObject private var viewModel = GroceryListViewModel()
    @State private var isAddingItem = false

    var body: some View {
        NavigationStack {
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
                    }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
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

// View for adding a new item to the grocery list
struct AddItemView: View {
    @ObservedObject var viewModel: GroceryListViewModel
    @Binding var isAddingItem: Bool
    @State private var newItemName: String = ""
    @State private var selectedCategory: GroceryItem.Category = .uncategorized
    @State private var isDictationActive = false
    
    var body: some View {
        VStack {
            // Text field for entering item name with voice typing support
            HStack {
                TextField("Item Name", text: $newItemName)
                    .focusable(true) // Enable focus to activate dictation
                    .onTapGesture {
                        // Present dictation when tapped on the text field
                        isDictationActive = true
                    }
                
                // Mic button for dictation
                Button(action: {
                    // Activate dictation when mic button is pressed
                    isDictationActive = true
                }) {
                    Image(systemName: "mic")
                        .imageScale(.medium)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 8)
                .foregroundColor(.blue)
            }
            
            // Picker for selecting item category
            Picker("Category", selection: $selectedCategory) {
                ForEach(GroceryItem.Category.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .padding(.bottom, 20)
            .frame(height: 60)
            
            // Save and Cancel buttons
            HStack {
                Button("Save") {
                    viewModel.addItem(name: newItemName, category: selectedCategory)
                    isAddingItem = false
                }
                .padding()
                .frame(height: 20)
                
                Button("Cancel") {
                    isAddingItem = false
                }
                .padding()
                .frame(height: 20)
            }
        }
        .navigationTitle("Add Item")
        .onAppear {
            // Activate voice dictation when view appears
            activateVoiceDictation()
        }
    }
    
    // Function to activate voice dictation
    private func activateVoiceDictation() {
        if isDictationActive {
            WKExtension.shared().visibleInterfaceController?.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain, completion: { result in
                guard let result = result?.first as? String else { return }
                newItemName = result
                isDictationActive = false
            })
        }
    }
}
// Preview for GroceryListView
struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchGroceryListView()
    }
}
