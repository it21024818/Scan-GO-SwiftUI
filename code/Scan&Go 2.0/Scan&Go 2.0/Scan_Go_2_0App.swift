//
//  Scan_Go_2_0App.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import SwiftUI
import Firebase

// Main entry point for the Scan&Go 2.0 application
@main
struct Scan_Go_2_0App: App {
    // Persistence controller for Core Data
    let persistenceController = PersistenceController.shared
    
    // State object for managing user authentication
    @StateObject private var user = User()
    
    // State object for managing scanning functionality
    @StateObject private var vm = ScanViewModel()
    
    // Initialize Firebase configuration
    init() {
        FirebaseApp.configure()
    }

    // Main body of the application scene
    var body: some Scene {
        WindowGroup {
            // Check if the user is authenticated
            if user.isAuthenticated {
                // Display main content if the user is authenticated
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(vm)
                    .environmentObject(user)
                    .task {
                        await vm.requestDataScannerAccessStatus()
                    }
            } else {
                // Display login view if the user is not authenticated
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(vm)
                    .environmentObject(user)
                    .task {
                        await vm.requestDataScannerAccessStatus()
                    }
            }
        }
    }
}
