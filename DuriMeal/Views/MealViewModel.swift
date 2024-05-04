//
//  MealViewModel.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var crawlingManager = CrawlingManager()

    init() {
        fetchMeals()
    }

    func fetchMeals() {
        crawlingManager.fetchDailyMenu { [weak self] meals in
            DispatchQueue.main.async {
                self?.meals = meals
            }
        }
    }
}
