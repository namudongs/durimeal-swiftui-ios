//
//  Meal.swift
//  DuriMeal
//
//  Created by namdghyun on 3/16/24.
//

import Foundation

struct Meal: Identifiable {
    let id = UUID()
    var place: String
    var day: String
    var time: String
    var menu: String
}
