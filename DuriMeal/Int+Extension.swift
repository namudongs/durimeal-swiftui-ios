//
//  Int+Extension.swift
//  DuriMeal
//
//  Created by namdghyun on 5/5/24.
//

import Foundation

extension Int {
    func dayIndexToString() -> String {
        switch self {
        case 3:
            return "월"
        case 4:
            return "화"
        case 5:
            return "수"
        case 6:
            return "목"
        case 7:
            return "금"
        case 8:
            return "토"
        default:
            return "일"
        }
    }
}
