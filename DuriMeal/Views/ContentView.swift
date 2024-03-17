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
            for meal in meals {
                if meal.place == "이룸관" {
                    print(meal)
                }
            }
        } label: {
            Text("식단표 프린트하기")
        }

    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
