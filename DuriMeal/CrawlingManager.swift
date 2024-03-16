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
    func fetchDailyMenu() {
        let urlStr = "https://knudorm.kangwon.ac.kr/content/K11"
        
        AF.request(urlStr).responseString { (response) in
            guard let html = response.value else {
                return
            }
            
            do {
                // 재정생활관 새롬관 (#latest02)
                // 요일 = tr:nth-child("월2, 화3, 수4, 목5, 금6, 토7, 일8") > td:nth-child("아침2, 점심3, 저녁4")
                
                // 재정생활관 이룸관 (#latest03)
                // 요일 = tr:nth-child("월2, 화3, 수4, 목5, 금6, 토7, 일8") > td:nth-child("아침2, 점심3, 저녁4")
                
                let doc: Document = try SwiftSoup.parse(html)
                let elements: Elements = try doc.select("#latest03 > div")
                for element in elements {
                    print(try element.select("tr:nth-child(2) > td:nth-child(2)").text())
                }
                
            } catch {
                print("error")
            }
        }
    }
}
