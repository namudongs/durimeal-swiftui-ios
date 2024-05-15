//
//  MealViewModel.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedPlace: Place = .saerom
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
    
    
}

