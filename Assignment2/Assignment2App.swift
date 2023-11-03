//
//  Assignment2App.swift
//  Assignment2
//
//  Created by Leo Cheung on 3/11/2023.
//

import SwiftUI

@main
struct Assignment2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
