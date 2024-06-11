//
//  Scan_Go_2_0App.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import SwiftUI
import Firebase

@main
struct Scan_Go_2_0App: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var user = User()
    @StateObject private var vm = ScanViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if user.isAuthenticated {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(vm)
                    .environmentObject(user)
                    .task {
                        await vm.requestDataScannerAccessStatus()
                    }
            } else {
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
