//
//  DuriMealApp.swift
//  DuriMeal
//
//  Created by namdghyun on 3/9/24.
//

import SwiftUI

@main
struct DuriMealApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
