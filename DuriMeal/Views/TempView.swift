//
//  TempView.swift
//  DuriMeal
//
//  Created by namdghyun on 5/4/24.
//

import SwiftUI

struct TempView: View {
    @ObservedObject var viewModel = MealViewModel()
    @State var selectedRestaurant = "새롬관"
    let restaurants = ["새롬관", "이룸관", "백록관", "천지관", "두리관"]
    let time = ["아침", "점심", "저녁"]
    
    var body: some View {
//        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                // HeaderButtons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(restaurants, id: \.self) { restaurant in
                            restaurantButton(name: restaurant)
                            if restaurants.last != restaurant {
                                Rectangle()
                                    .frame(width: 2)
                                    .foregroundStyle(.primary.opacity(0.2))
                                    .padding(.vertical, -5)
                            }
                        }
                    }
                    .frame(maxHeight: 20)
                }
                // HeaderButtons End
                ScrollView(showsIndicators: false) {
                    ForEach(time, id: \.self) { item in
                        mealView(time: item, meals: viewModel.meals.filter {
                            $0.place == selectedRestaurant && $0.day == "화" && $0.time == item
                        })
                    }
                }
            }
            .padding()
//        }
    }
    
    @ViewBuilder
    func restaurantButton(name: String) -> some View {
        let notSelectedColor: Color = .secondary.opacity(0.5)
        let selectedColor: Color = .primary
        
        Text(name).foregroundStyle(name == selectedRestaurant ?
                                   selectedColor : notSelectedColor).font(.title2).bold()
            .onTapGesture {
                withAnimation(.bouncy) {
                    selectedRestaurant = name
                }
                
            }
    }
    
    @ViewBuilder
    func mealView(time: String, meals: [Meal]) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: timeToImageString(time: time))
                Text(time).font(.title2).bold()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.primary.opacity(0.5))
                .padding(.vertical, -5)
            ForEach(meals) { meal in
                Text(meal.menu.replacingOccurrences(of: " ", with: "\n"))
                    .font(.title3)
            }
            Spacer()
        }
    }
    
    func timeToImageString(time: String) -> String {
        if time == "아침" {
            return "sun.horizon"
        } else if time == "점심" {
            return "sun.max"
        } else {
            return "moon.stars"
        }
    }
}

#Preview {
    TempView()
}
