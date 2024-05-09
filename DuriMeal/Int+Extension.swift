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
    
    func timeIndexToString() -> String {
        switch self {
        case 2:
            return "아침"
        case 3:
            return "점심"
        case 4:
            return "저녁"
        default:
            return "없음"
        }
    }
    
    func placeIndexToSelector() -> String {
        switch self {
        case 1:
            return "#latest02"
        case 2:
            return "#latest03"
        default:
            return "없음"
        }
    }
    
    func placeIndexToString() -> String {
        switch self {
        case 1:
            return "새롬관"
        case 2:
            return "이룸관"
        default:
            return "없음"
        }
    }
}
