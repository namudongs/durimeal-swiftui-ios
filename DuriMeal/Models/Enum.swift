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
    case chunji = "천지관"
    case bakrok = "백록관"
    case duri = "두리관"
    
    func needSubplace() -> Bool {
        switch self {
        case .chunji, .bakrok, .duri:
            return true
        case .saerom, .eroom:
            return false
        }
    }
    
    func returnSubplace() -> [String] {
        switch self {
        case .chunji:
            return ["천원의 아침밥", "천지백두산", "특식/한식(랜덤)", "양식", "스낵", "하루정식"]
        case .bakrok:
            return ["천원의 아침밥", "백록한라산", "뚝배기(THE진국) 한그릇/플러스", "양식", "스낵", "백록정식"]
        case .duri:
            return ["크누정식", "뚝배기정식", "돈가스정식", "크누석식"]
        default:
            return []
        }
    }
    
    func initSubplace() -> String {
        switch self {
        case .chunji, .bakrok:
            return "천원의 아침밥"
        case .duri:
            return "크누정식"
        default:
            return ""
        }
    }
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
