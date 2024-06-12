//
//  ContentView.swift
//  Scan&GoWatch Watch App
//
//  Created by Dinuka Dissanayake on 6/12/24.

import SwiftUI

struct WatchContentView: View {
    var body: some View {
        TabView {
            WatchHomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            WatchGroceryListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Grocery List")
                }
            
//            WatchScanView()
//                .tabItem {
//                    Image(systemName: "barcode.viewfinder")
//                    Text("Scan")
//                }
            
            WatchCartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            
            WatchProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct WatchContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchContentView()
    }
}

