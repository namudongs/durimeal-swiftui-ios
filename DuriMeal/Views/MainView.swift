//
//  TempView.swift
//  DuriMeal
//
//  Created by namdghyun on 5/4/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MealViewModel()
    @ScaledMetric(relativeTo: .title2) var dynamicHeight = 30
    
    var body: some View {
        VStack(spacing: 20) {
            // HeaderButtons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(vm.places, id: \.self) { place in
                        placeButton(place: place)
                        if vm.places.last != place {
                            Rectangle()
                                .frame(width: 2)
                                .foregroundStyle(.primary.opacity(0.2))
                                .padding(.vertical, 5)
                        }
                    }
                }
                .frame(maxHeight: dynamicHeight)
            }
            // HeaderButtons End
            ScrollView(showsIndicators: false) {
                ForEach(vm.times, id: \.self) { time in
                    showMenu(time: time, meals: vm.meals.filter {
                        $0.place == vm.selectedPlace.rawValue && $0.day == "화" && $0.time == time.rawValue
                    })
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func placeButton(place: Place) -> some View {
        let notSelectedColor: Color = .secondary.opacity(0.5)
        let selectedColor: Color = .primary
        
        Text(place.rawValue).foregroundStyle(place == vm.selectedPlace ?
                                   selectedColor : notSelectedColor).font(.title2).bold()
            .onTapGesture {
                withAnimation(.bouncy) {
                    vm.selectedPlace = place
                }
                
            }
    }
    
    @ViewBuilder
    func showMenu(time: Time, meals: [Meal]) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: time.timeToImageString())
                Text(time.rawValue).font(.title2).bold()
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
}

#Preview {
    MainView()
}
