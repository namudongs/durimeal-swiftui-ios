//
//  ContentView.swift
//  DuriMeal
//
//  Created by namdghyun on 3/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let crawlingManager = CrawlingManager()
    
    var body: some View {
        Button(action: {
            crawlingManager.fetchDailyMenu()
        }, label: {
            Text("식단표 불러오기")
        })
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
