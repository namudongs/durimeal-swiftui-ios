//
//  RestaurantCrawlingManager.swift
//  DuriMeal
//
//  Created by namdghyun on 5/5/24.
//

import SwiftUI
import SwiftSoup

class RestaurantCrawlingManager {
    func fetchDailyMenu() {
        print("시작")
        let urlStr = URL(string: "https://wwwk.kangwon.ac.kr/www/selecttnCafMenuListWU.do?key=1077&sc1=CC20&sc2=CC")
        guard let urlStr = urlStr else { return }
        
        var meals: [Meal] = []
        
        do {
            let html = try String(contentsOf: urlStr, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let _: Elements = try doc.select("div.over_scroll_table").select("thead") // 일자 추적을 위한 상수
            let tbody: Elements = try doc.select("div.over_scroll_table").select("tbody")
            
            for index in 1...4 {
                let place = try tbody.select("tr:nth-child(\(index))").select("th")[0].text()
                let time = try tbody.select("tr:nth-child(\(index))").select("th")[1].text()
                for menuIdx in 3...7 {
                    let menu = try tbody.select("tr:nth-child(\(index))").select("td:nth-child(\(menuIdx))").text()
                    
                    let meal = Meal(place: "백록관", subPlace: place, day: "\(index)", time: time, menu: menu)
                    
                    meals.append(meal)
                }
            }
            for meal in meals {
                print(meal)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
