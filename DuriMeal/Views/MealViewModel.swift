//
//  MealViewModel.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var crawlingManager = DomitoryCrawlingManager()
    private var restaurantCrawlingManager = RestaurantCrawlingManager()
    
    init() {
        fetchMeals()
    }
    
    func fetchMeals() {
            crawlingManager.fetchDailyMenu { [weak self] dormitoryMeals in
                self?.restaurantCrawlingManager.fetchDailyMenu { restaurantMeals in
                    DispatchQueue.main.async {
                        self?.meals = dormitoryMeals + restaurantMeals
                    }
                }
            }
        }
}

