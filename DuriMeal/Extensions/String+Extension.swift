//
//  String+Extension.swift
//  DuriMeal
//
//  Created by namdghyun on 5/16/24.
//

import Foundation

extension String {
    func subToIcon() -> String {
        switch self {
        case "천원의 아침밥":
            return "sun.horizon"
        case "백록한라산":
            return "sun.max"
        case "뚝배기(THE진국) 한그릇/플러스":
            return "sun.max"
        case "양식":
            return "sun.max"
        case "스낵":
            return "sun.max"
        case "백록정식":
            return "moon.stars"
        case "천지백두산":
            return "sun.max"
        case "특식/한식(랜덤)":
            return "sun.max"
        case "하루정식":
            return "moon.stars"
        case "크누정식":
            return "sun.max"
        case "뚝배기정식":
            return "sun.max"
        case "돈가스정식":
            return "sun.max"
        case "크누석식":
            return "moon.stars"
        default:
            return ""
        }
    }
}
