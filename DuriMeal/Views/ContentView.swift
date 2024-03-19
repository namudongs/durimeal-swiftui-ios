//
//  ContentView.swift
//  DuriMeal
//
//  Created by namdghyun on 3/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel = MealViewModel()
    @State private var selectedPlace: Place = .sarom
    @State private var showingConfirmationDialog: Bool = false
    @State private var campusName: String = "춘천캠퍼스"
    @State private var selectedDay: String = "월"
    
    private var confirmationDialogMessage: String = "캠퍼스를 선택하세요"
    
    var body: some View {
        VStack {
            HStack {
                let daysOfWeek = ["월", "화", "수", "목", "금", "토", "일"]
                ForEach(daysOfWeek, id: \.self) { day in
                    Button(day) {
                        selectedDay = day
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(selectedDay == day ? .red : .black)                }
            }
            TabView {
                MealView(meals: viewModel.meals.filter { $0.place == "새롬관" && $0.day == selectedDay})
                    .tabItem {
                      Image(systemName: "1.square.fill")
                      Text("새롬관")
                    }
                MealView(meals: viewModel.meals.filter { $0.place == "이룸관" && $0.day == selectedDay})
                    .tabItem {
                      Image(systemName: "2.square.fill")
                      Text("이룸관")
                    }
                MealView(meals: viewModel.meals.filter { $0.place == "천지관" && $0.day == selectedDay})
                    .tabItem {
                      Image(systemName: "3.square.fill")
                      Text("천지관")
                    }
                MealView(meals: viewModel.meals.filter { $0.place == "백록관" && $0.day == selectedDay})
                    .tabItem {
                      Image(systemName: "3.square.fill")
                      Text("백록관")
                    }
                MealView(meals: viewModel.meals.filter { $0.place == "크누테리아" && $0.day == selectedDay})
                    .tabItem {
                      Image(systemName: "3.square.fill")
                      Text("크누테리아")
                    }
                }
                .font(.headline)
        }
        .onAppear {
            viewModel.fetchMeals()
        }
        
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
