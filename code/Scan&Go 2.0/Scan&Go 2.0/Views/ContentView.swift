//
//  ContentView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import SwiftUI
import CoreData

// Main view displaying tab navigation
struct ContentView: View {
    var body: some View {
        TabView {
            // Home tab
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundColor(.orange)
                    Text("Home")
                }

            // Grocery List tab
            GroceryListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.orange)
                    Text("Grocery List")
                }

            // Scan tab
            ScanView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder").foregroundColor(.orange)
                    Text("Scan")
                }

            // Cart tab
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                        .foregroundColor(.orange)
                    Text("Cart")
                }

            // Profile tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .foregroundColor(.orange)
                    Text("Profile")
                }
        }
    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
