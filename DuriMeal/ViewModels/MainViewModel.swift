//
//  MealViewModel.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedPlace: Place = .saerom
    @Published var selectedSubPlace: String = Place.bakrok.returnSubplace().first!
    @Published var day: String = "목"
    
    private var manager = SwiftSoupManager()
    
    let places: [Place] = Place.allCases
    let times: [Time] = Time.allCases
    
    init() {
        fetchMeals()
    }
    
    func fetchMeals() {
        let paramArr: [Int] = [10, 20, 30]
        
        for param in paramArr {
            manager.fetchUnivMenus(param: param) { meals in
                DispatchQueue.main.async {
                    self.meals.append(contentsOf: meals)
                }
            }
        }
        
        manager.fetchDomMenus { meals in
            DispatchQueue.main.async {
                self.meals.append(contentsOf: meals)
            }
        }
    }
    
    func filteredMeals(for time: Time) -> [Meal] {
        return if selectedPlace.needSubplace() {
            meals.filter {
                $0.place == selectedPlace.rawValue 
                && $0.day == day
                && $0.time == time.rawValue
                && $0.subPlace == selectedSubPlace
            }
        } else {
            meals.filter {
                $0.place == selectedPlace.rawValue 
                && $0.day == day
                && $0.time == time.rawValue
            }
        }
    }
}

