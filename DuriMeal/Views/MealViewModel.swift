//
//  MealViewModel.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var manager = SwiftSoupManager()
    
    init() {
        fetchMeals()
    }
    
    func fetchMeals() {
        manager.fetchUnivMenus { meals in
            DispatchQueue.main.async {
                self.meals.append(contentsOf: meals)
            }
        }
        
        manager.fetchDomMenus { meals in
            DispatchQueue.main.async {
                self.meals.append(contentsOf: meals)
            }
        }
        
       
    }
}

