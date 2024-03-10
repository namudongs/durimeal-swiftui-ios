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
        Text("Hello, World!!")
    }
    
    let urlAdress = "https://knudorm.kangwon.ac.kr/content/K11"
    
    func mealParse() {
        guard let url = URL(string: urlAdress) else { return }
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
//            let meal: String =
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }

    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
