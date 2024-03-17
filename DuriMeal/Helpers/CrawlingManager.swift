//
//  CrawlingManager.swift
//  DuriMeal
//
//  Created by namdghyun on 3/16/24.
//

import Foundation
import SwiftSoup
import Alamofire

struct CrawlingManager {
    func fetchDailyMenu(completion: @escaping ([Meal]) -> Void) {
        let urlStr = "https://knudorm.kangwon.ac.kr/content/K11"
        AF.request(urlStr).responseString { response in
            guard let html = response.value else { return }
            let meals = parseHTML(html: html)
            completion(meals)
        }
    }
    
    func parseHTML(html: String) -> [Meal] {
        let dormitories = ["#latest02": "새롬관", "#latest03": "이룸관"] // 새롬관과 이룸관
        let days = ["월": 2, "화": 3, "수": 4, "목": 5, "금": 6, "토": 7, "일": 8]
        let times = ["아침": 2, "점심": 3, "저녁": 4]
        var meals: [Meal] = []
        
        do {
            let doc: Document = try SwiftSoup.parse(html)
                    for (index, domitory) in dormitories {
                        for (day, dayIndex) in days {
                            for (time, timeIndex) in times {
                                let elements: Elements = try doc.select("\(index) > div")
                                for element in elements {
                                    let ele = try element.select("tr:nth-child(\(dayIndex)) > td:nth-child(\(timeIndex))").text()
                                    if ele.isEmpty || ele.contains("~") {
                                        continue
                                    }
                                    let meal = Meal(place: domitory, day: day, time: time, menu: ele)
                                    meals.append(meal)
                                }
                            }
                        }
                    }
        } catch Exception.Error(_, let message) {
            print("Parsing error: \(message)")
        } catch {
            print("Unknown error")
        }
        
        return meals
    }
}
