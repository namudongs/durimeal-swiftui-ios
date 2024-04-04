//
//  WeekdaySelector.swift
//  DuriMeal
//
//  Created by namdghyun on 4/4/24.
//

import SwiftUI

enum weekday: String, CaseIterable {
    case MON = "월"
    case TUE = "화"
    case WED = "수"
    case THU = "목"
    case FRI = "금"
    case SAT = "토"
    case SUN = "일"
}

struct WeekdaySelector: View {
    @State private var selectedPicker: weekday = .MON
    @Namespace private var animaion
    @ObservedObject var viewModel = MealViewModel()
    
    var body: some View {
        VStack {
            animate()
            MealView(meals: viewModel.meals.filter
                     { $0.place == "새롬관" && $0.day == selectedPicker.rawValue})
        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(weekday.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/4, minHeight: 50)
                        .foregroundColor(selectedPicker == item ? .black : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 3)
//                            .matchedGeometryEffect(id: "MON", in: animation)
                    }
                        
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

#Preview {
    WeekdaySelector()
}
