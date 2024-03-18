//
//  Place.swift
//  DuriMeal
//
//  Created by namdghyun on 3/18/24.
//

import Foundation

enum Place: String, CaseIterable, Identifiable {
    case sarom
    case eroom
    case chunji
    case bakrok
    case duri
    
    var id: String { self.rawValue }
    var description: String {
        switch self {
        case .sarom:
            return "새롬관"
        case .eroom:
            return "이룸관"
        case .chunji:
            return "천지관"
        case .bakrok:
            return "백록관"
        case .duri:
            return "크누테리아"
        }
    }
}
