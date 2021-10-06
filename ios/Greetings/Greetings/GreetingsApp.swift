//
//  GreetingsApp.swift
//  Greetings
//
//  Created by Artem Kovardin on 07.10.2021.
//

import SwiftUI

@main
struct GreetingsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
