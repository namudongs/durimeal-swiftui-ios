//
//  Enum.swift
//  DuriMeal
//
//  Created by namdghyun on 5/15/24.
//

import Foundation

enum Place: String, CaseIterable {
    case saerom = "새롬관"
    case eroom = "이룸관"
    case bakrok = "백록관"
    case chunji = "천지관"
    case duri = "두리관"
}

enum Time: String, CaseIterable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    
    func timeToImageString() -> String {
        switch self {
        case .breakfast:
            return "sun.horizon"
        case .lunch:
            return "sun.max"
        case .dinner:
            return "moon.stars"
        }
    }
}
