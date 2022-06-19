//
//  MoneyAssistantSwiftUIApp.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI

@main
struct MoneyAssistantSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MoneyThreadsContentView(
                viewModel: .init(
                    moneyThreadCDController: MoneyThreadCDController()
                )
            )
        }
    }
}
