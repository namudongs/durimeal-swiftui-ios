//
//  Theme.swift
//  DuriMeal
//
//  Created by namdghyun on 5/16/24.
//

import SwiftUI

struct Theme {
    static func myBackgroundColor(forSchme scheme: ColorScheme) -> EllipticalGradient {
        let lightColor = EllipticalGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.63, green: 0.68, blue: 0.82), location: -0.05),
                Gradient.Stop(color: Color(red: 0.8, green: 0.83, blue: 0.9), location: 0.52),
                Gradient.Stop(color: .white, location: 1.00),
            ],
            center: UnitPoint(x: 1, y: 1),
            startRadiusFraction: 0.1,
            endRadiusFraction: 1.4
        )
        
        let darkColor = EllipticalGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.09, green: 0.12, blue: 0.21), location: 0.00),
                Gradient.Stop(color: Color(red: 0.06, green: 0.08, blue: 0.12), location: 0.45),
                Gradient.Stop(color: .black, location: 1.00),
            ],
            center: UnitPoint(x: 1, y: 1),
            startRadiusFraction: 0,
            endRadiusFraction: 1.1
        )
        
        
        switch scheme {
        case .light: return lightColor
        case .dark: return darkColor
        @unknown default: return lightColor
        }
    }
}
