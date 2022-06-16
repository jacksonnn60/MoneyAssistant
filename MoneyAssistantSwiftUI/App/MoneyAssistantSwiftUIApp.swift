//
//  MoneyAssistantSwiftUIApp.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI

@main
struct MoneyAssistantSwiftUIApp: App {
//    let persistenceController = PersistenceController.shared
//    @ObservedObject private var cdController = CDController()
    

    var body: some Scene {
        WindowGroup {
            TabBarScreen()
//                .environment(\.managedObjectContext, cdController.container.viewContext)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
