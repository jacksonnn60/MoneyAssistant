//
//  MainScreen.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI

typealias EmptyClosure = (() -> ())

struct MoneyThreadsContentView<ViewModel : MainScreenViewModel>: View {
    
    // MARK: - Dynamic properties
    
    @ObservedObject var viewModel: ViewModel
    @State private var alertIsPresented = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center) {
            List(viewModel.moneyThreads) { moneyThread in
                MoneyThreadCellView(moneyThread: moneyThread) {
                    self.viewModel.delete(moneyThread)
                }
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchThreads()
            }
            
            // MARK: - New money thread button
            
            Button {
                withAnimation(.customSpring) {
                    alertIsPresented.toggle()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, maxHeight: 54)
                        .padding([.leading, .trailing])
                    
                    Text("New money thread")
                        .font(.system(.title2, design: .default))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .shadow(radius: 12)
            
        }.overlay {
            
            // MARK: - Alert
            
            MoneyThreadAlert(
                isPresented: $alertIsPresented,
                threadTitle: $viewModel.threadTitle,
                threadAmount: $viewModel.threadAmount,
                threadDescription: $viewModel.threadDescription,
                spentButtonDidTap: { viewModel.saveThread(.moneySpent) },
                earnButtonDidTap: { viewModel.saveThread(.moneyEarned) }
            )
            
        }
    }
}
