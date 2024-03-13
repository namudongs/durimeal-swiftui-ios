//
//  ContentView.swift
//  DuriMeal
//
//  Created by namdghyun on 3/9/24.
//

import SwiftUI
import CoreData
import SwiftSoup

struct ContentView: View {
    var body: some View {
        Button(action: {
            fetchAndPrintMenu()
        }, label: {
            Text("식단표 불러오기")
        })
    }
    
    func fetchAndPrintMenu() {
        let urlString = "https://knudorm.kangwon.ac.kr/content/K11"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data, let html = String(data: data, encoding: .utf8) {
                    print("Parsing Start")
                    // HTML 파싱
                    do {
                        let doc: Document = try SwiftSoup.parse(html)
                        let days = try doc.select("tr")
                        
                        for day in days {
                            var dayMenus: [String] = []
                            let menus = try day.select("td")
                            
                            for menu in menus {
                                let menuItems = try menu.html().components(separatedBy: "<br>").filter { !$0.isEmpty }
                                let cleanedMenuItems = menuItems.compactMap { try? SwiftSoup.clean($0, Whitelist.none()) }
                                dayMenus.append(contentsOf: cleanedMenuItems)
                            }
                            
                            print(dayMenus) // 출력
                        }
                    } catch Exception.Error(let type, let message) {
                        print("Type: \(type), Message: \(message)")
                    } catch {
                        print("error")
                    }
                }
            }.resume()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
