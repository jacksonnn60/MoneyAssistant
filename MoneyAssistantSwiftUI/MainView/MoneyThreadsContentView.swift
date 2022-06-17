//
//  MainScreen.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI
import AudioToolbox

typealias EmptyClosure = (() -> ())

struct MoneyThreadsContentView<ViewModel : MainScreenViewModel>: View {
    
    // MARK: - Dynamic properties
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var alertIsPresented = false
    @State private var editViewIsPresented = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center) {
            List(viewModel.moneyThreads) { moneyThread in
                MoneyThreadCellView(
                    moneyThread: moneyThread,
                    cellAction: {
                        switch $0 {
                        case .deleteDidSwiped:
                            viewModel.delete(moneyThread)
                        case .cellDidTap, .editDidSwiped:
                            viewModel.selectedThread = moneyThread
                        
                            editViewIsPresented.toggle()
                        }
                    }
                )
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchThreads()
            }
            
            // MARK: - New money thread button
            
            VStack {
                HStack {
                    let spentString = "Spent: $\(String(format: "%.2f", viewModel.totalSpent).trimmingCharacters(in: .whitespaces))"
                    
                    let earnedString = "Earned: $\(String(format: "%.2f", viewModel.totalEarned).trimmingCharacters(in: .whitespaces))"
                    
                    Text(earnedString)
                        .font(.callout)
                        .bold()
                        .foregroundColor(.green)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text(spentString)
                        .font(.callout)
                        .bold()
                        .foregroundColor(.red)
                        .padding(.trailing)
                }
                
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
                .shadow(radius: 8)
            }
            
        }
        .sheet(isPresented: $editViewIsPresented) {
            EditThreadContentView(moneyThread: viewModel.selectedThread)
        }
        .overlay {
            
            // MARK: - Alert
            
            MoneyThreadAlert(
                isPresented: $alertIsPresented,
                threadTitle: $viewModel.threadTitle,
                threadAmount: $viewModel.threadAmount,
                threadDescription: $viewModel.threadDescription,
                cellAction: {
                    switch $0 {
                    case .spentButtonDidTap: viewModel.saveThread(.moneySpent)
                    case .earnButtonDidTap: viewModel.saveThread(.moneyEarned)
                    }
                }
            )
            
        }
    }
}

struct MyPreview: PreviewProvider {
    static var previews: some View {
        MoneyThreadsContentView(viewModel: MainScreenViewModel(moneyThreadCDController: MoneyThreadCDController()))
    }
}
