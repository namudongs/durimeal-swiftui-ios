//
//  RestaurantCrawlingManager.swift
//  DuriMeal
//
//  Created by namdghyun on 5/5/24.
//

import SwiftUI
import SwiftSoup

class SwiftSoupManager {
    
    /// 천지관, 백록관, 두리관 메뉴를 불러오는 함수
    func fetchUnivMenus(param: Int, completion: @escaping ([Meal]) -> Void) {
        let urlStr = URL(string: "https://wwwk.kangwon.ac.kr/www/selecttnCafMenuListWU.do?key=1077&sc1=CC\(param)&sc2=CC")
        guard let urlStr = urlStr else { return }
        var meals: [Meal] = []
        
        let task = URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let html = String(data: data, encoding: .utf8) ?? ""
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let _: Elements = try doc.select("div.over_scroll_table").select("thead") // 일자 추적을 위한 상수
                let tbody: Elements = try doc.select("div.over_scroll_table").select("tbody")
                for index in param.paramToRange() {
                    let place = try tbody.select("tr:nth-child(\(index))").select("th")[0].text()
                    let time = try tbody.select("tr:nth-child(\(index))").select("th")[1].text()
                    
                    for menuIdx in 3...7 {
                        let menu = try tbody.select("tr:nth-child(\(index))").select("td:nth-child(\(menuIdx))").text()
                        let meal = Meal(place: param.paramToPlace(), subPlace: place, day: menuIdx.dayIndexToString(), time: time, menu: menu)
                        meals.append(meal)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            completion(meals)
        }
        task.resume()
    }
    
    /// 새롬관, 이룸관 메뉴를 불러오는 함수
    func fetchDomMenus(completion: @escaping ([Meal]) -> Void) {
        let urlStr = URL(string: "https://knudorm.kangwon.ac.kr/content/K11")
        guard let urlStr = urlStr else { return }
        var meals: [Meal] = []
        
        let task = URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let html = String(data: data, encoding: .utf8) ?? ""
            for placeIndex in 1...2 {
                do {
                    let doc: Document = try SwiftSoup.parse(html)
                    let tbody: Elements = try doc.select(placeIndex.placeIndexToSelector()).select("div:nth-child(7)").select("tbody")
                    for index in 2...8 {
                        let all = try tbody.select("tr:nth-child(\(index))")
                        let day = try all.select("th")
                        for time in 2...4 {
                            let menus = try all.select("td:nth-child(\(time))")
                            let meal = try Meal(place: placeIndex.placeIndexToString(), day: day.text(), time: time.timeIndexToString(), menu: menus.text())
                            
                            meals.append(meal)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion(meals)
        }
        task.resume()
    }
}
