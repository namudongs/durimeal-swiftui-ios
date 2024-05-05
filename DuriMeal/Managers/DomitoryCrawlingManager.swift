//
//  CrawlingManager.swift
//  DuriMeal
//
//  Created by namdghyun on 3/16/24.
//

import Foundation
import SwiftSoup
import Alamofire

class DomitoryCrawlingManager {
    func fetchDailyMenu(completion: @escaping ([Meal]) -> Void) {
        let urlStr = "https://knudorm.kangwon.ac.kr/content/K11"
        AF.request(urlStr).responseString { response in
            guard let html = response.value else { return }
            let meals = self.parseHTML(html: html)
            completion(meals)
        }
    }
    
    func parseHTML(html: String) -> [Meal] {
        let place = ["#latest02": "새롬관", "#latest03": "이룸관"]
        let days = ["월": 2, "화": 3, "수": 4, "목": 5, "금": 6, "토": 7, "일": 8]
        let times = ["아침": 2, "점심": 3, "저녁": 4]
        let dayOrder = ["월": 1, "화": 2, "수": 3, "목": 4, "금": 5, "토": 6, "일": 7]
        let timeOrder = ["아침": 1, "점심": 2, "저녁": 3]
        
        var meals: [Meal] = []
        
        do {
            let doc: Document = try SwiftSoup.parse(html)
            for (index, domitory) in place {
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
                            
                            meals.sort { (meal1, meal2) -> Bool in
                                if let day1Order = dayOrder[meal1.day], let day2Order = dayOrder[meal2.day] {
                                    if day1Order == day2Order {
                                        return (timeOrder[meal1.time] ?? 0) < (timeOrder[meal2.time] ?? 0)
                                    }
                                    return day1Order < day2Order
                                }
                                return false
                            }
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
