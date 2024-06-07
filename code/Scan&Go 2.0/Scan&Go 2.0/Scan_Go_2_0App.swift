//
//  Scan_Go_2_0App.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import SwiftUI

@main
struct Scan_Go_2_0App: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var vm = ScanViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
    }
}
