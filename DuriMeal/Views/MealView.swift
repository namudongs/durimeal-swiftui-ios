//
//  MealView.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import SwiftUI

struct MealView: View {
    var backgroundColor: Color = .white
    var meals: [Meal]
    
    var body: some View {
        List(meals) { meal in
            VStack(alignment: .leading) {
                Text("\(meal.place) \(meal.day)요일 \(meal.time)")
                    .font(.footnote.bold())
                Text(meal.menu.replacingOccurrences(of: " ", with: "\n"))
                    .font(.caption)
            }
        }
    }
}

#Preview {
    MealView(meals: [])
}
