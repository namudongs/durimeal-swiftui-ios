//
//  TempView.swift
//  DuriMeal
//
//  Created by namdghyun on 5/4/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderButton(vm: vm)
            ScrollView(showsIndicators: false) {
                ForEach(vm.times, id: \.self) { time in
                    ShowMenu(time: time, meals: vm.filteredMeals(for: time))
                }
            }
        }
        .padding()
    }
}

fileprivate struct HeaderButton: View {
    @ObservedObject var vm: MainViewModel
    @ScaledMetric(relativeTo: .title2) var dynamicHeight = 30
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(vm.places, id: \.self) { place in
                    PlaceButton(vm: vm, place: place)
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
    }
}

fileprivate struct PlaceButton: View {
    @ObservedObject var vm: MainViewModel
    let place: Place
    let notSelectedColor: Color = .secondary.opacity(0.5)
    let selectedColor: Color = .primary
    
    var body: some View {
        Text(place.rawValue)
            .foregroundStyle(place == vm.selectedPlace ? selectedColor : notSelectedColor)
            .font(.title2)
            .bold()
            .onTapGesture {
                withAnimation(.bouncy) {
                    vm.selectedPlace = place
                }
            }
    }
}

fileprivate struct ShowMenu: View {
    let time: Time
    let meals: [Meal]
    
    var body: some View {
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
