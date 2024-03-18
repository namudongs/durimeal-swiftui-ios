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
    private var confirmationDialogMessage: String = "캠퍼스를 선택하세요"
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { showingConfirmationDialog = true }, label: {
                    Text(campusName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.down")
                }).confirmationDialog("",
                                      isPresented: $showingConfirmationDialog,
                                      titleVisibility: .hidden,
                                      actions: {
                    Button("춘천캠퍼스") { campusName = "춘천캠퍼스" }
                    Button("삼척캠퍼스") { campusName = "삼척캠퍼스" }
                    Button("도계캠퍼스") { campusName = "도계캠퍼스" }
                },
                                      message: {
                    confirmationDialogMessage == "" ? nil : Text(confirmationDialogMessage)
                }
                )
                .foregroundColor(.black)
            }
            Picker("Flavor",
                   selection: $selectedPlace) {
                ForEach(Place.allCases) {
                    Text($0.description).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle()
            )
            
            switch selectedPlace {
            case .sarom:
                MealView(meals: viewModel.meals.filter { $0.place == "새롬관"})
            case .eroom:
                MealView(meals: viewModel.meals.filter { $0.place == "이룸관"})
            case .chunji:
                MealView(backgroundColor: .green, meals: viewModel.meals.filter { $0.place == "천지관"})
            case .bakrok:
                MealView(backgroundColor: .brown, meals: viewModel.meals.filter { $0.place == "백록관"})
            case .duri:
                MealView(backgroundColor: .blue, meals: viewModel.meals.filter { $0.place == "두리관"})
            }
        }
        .onAppear {
            viewModel.fetchMeals()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
