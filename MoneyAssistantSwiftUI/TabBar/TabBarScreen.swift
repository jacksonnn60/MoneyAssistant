//
//  TabBarScreen.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI

struct TabBarScreen: View {
    // MARK: - Body
    
    var body: some View {
        TabView {
            MoneyThreadsContentView(viewModel: MainScreenViewModel(moneyThreadCDController: MoneyThreadCDController()))
                .tabItem {
                    Label("Main", systemImage: "dollarsign.square")
                }
        }
        
    }
}

struct TabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScreen()
    }
}
