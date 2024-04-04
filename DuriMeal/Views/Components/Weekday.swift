//
//  Weekday.swift
//  DuriMeal
//
//  Created by namdghyun on 4/4/24.
//

import SwiftUI

struct Weekday: View {
    var day: String = "월"
    var num: Int = 1
    
    var body: some View {
        VStack {
            Text("\(day)")
            Text("\(num)")
        }
    }
}
