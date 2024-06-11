//
//  ContentView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundColor(.orange)
                    Text("Home")
                }

            GroceryListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.orange)
                    Text("Grocery List")
                }

            ScanView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder").foregroundColor(.orange)
                    Text("Scan")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                        .foregroundColor(.orange)
                    Text("Cart")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .foregroundColor(.orange)
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
