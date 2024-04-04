//
//  NavigationHeader.swift
//  DuriMeal
//
//  Created by namdghyun on 4/4/24.
//

import SwiftUI

struct NavigationHeader: View {
    var campusName: String = "춘천"
    
    var body: some View {
        HStack {
            Button(action: {
              print("Tapped Campus")
            }, label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 20, height: 10)
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            })
            Text("\(campusName)캠퍼스")
                .font(.system(size: 30, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    NavigationHeader()
}
