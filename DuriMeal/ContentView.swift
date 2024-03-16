//
//  ContentView.swift
//  DuriMeal
//
//  Created by namdghyun on 3/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var meals: [Meal] = []
    private let crawlingManager = CrawlingManager()
    
    var body: some View {
        Button(action: {
            crawlingManager.fetchDailyMenu { meal in
                self.meals = meal
            }
        }, label: {
            Text("식단표 불러오기")
        })
        Button {
//            print(self.meals)
        } label: {
            Text("식단표 프린트하기")
        }

    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
