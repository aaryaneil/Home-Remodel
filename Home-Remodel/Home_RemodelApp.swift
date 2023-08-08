//
//  Home_RemodelApp.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 8/8/23.
//

import SwiftUI

@main
struct Home_RemodelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
