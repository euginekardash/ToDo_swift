//
//  TaksApp.swift
//  Taks
//
//  Created by Taqtile on 16.12.24.
//

import SwiftUI
import SwiftData

@main
struct TaksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDo.self)
    }
}

@Model class ToDo {
    var title: String
    var subTitle: String
    var isCompleted: Bool
    
    init(title: String, subTitle: String, isCompleted: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.isCompleted = isCompleted
    }
}

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        !lhs && rhs
    }
}
