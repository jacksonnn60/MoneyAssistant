//
//  MainScreenViewModel.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI
import Combine

enum MoneyThreadItem {
    case moneyThread(MoneyThread)
    case dateSeparator
}

protocol IMainScreenViewModel: ObservableObject {
    var moneyThreads: [MoneyThread] { get }
    var selectedThread: MoneyThread? { set get }
    
    var totalSpent: Double { get }
    var totalEarned: Double { get }
        
    func delete(_ moneyThread: MoneyThread)
    func saveThread(_ reason: MoneyThreadReason)
}

final class MainScreenViewModel: IMainScreenViewModel {
    
    private var moneyThreadCDController: MoneyThreadCDController
    
    // MARK: - Init
    
    // play role of bag
    private var cancellableBag: Set<AnyCancellable> = []
    
    init(moneyThreadCDController: MoneyThreadCDController) {
        self.moneyThreadCDController = moneyThreadCDController
        
        // change local moneyThreads from moneyThreadCDController
        self.moneyThreadCDController.$moneyThreads.sink { moneyThreads in
            DispatchQueue.main.async {
                self.moneyThreads = moneyThreads
                
                self.totalSpent = self.calculate(.moneySpent, in: moneyThreads)
                self.totalEarned = self.calculate(.moneyEarned, in: moneyThreads)
            }
            
        // store sink in bag to clear in future.
        }.store(in: &cancellableBag)
        
    }
    
    deinit {
        cancellableBag.removeAll()
    }
    
    // MARK: - Observables
    
    @Published var threadTitle: String = ""
    @Published var threadAmount: String = ""
    @Published var threadDescription: String = ""
    
    @Published var moneyThreads: [MoneyThread] = []
    @Published var selectedThread: MoneyThread?
    
    @Published var totalSpent: Double = 0.0
    @Published var totalEarned: Double = 0.0
    
    // MARK: - IMainScreenViewModel
    
    func fetchThreads() {
        moneyThreadCDController.fetchData()
    }
    
    func saveThread(_ reason: MoneyThreadReason) {
        moneyThreadCDController.save(title: threadTitle, description: threadDescription, amount: Double(threadAmount) ?? 0.0, reason: reason)
        
        threadTitle = ""
        threadAmount = ""
    }
    
    func delete(_ moneyThread: MoneyThread) {
        moneyThreadCDController.delete(moneyThread)
    }
}


private extension MainScreenViewModel {
    func calculate(_ threadReason: MoneyThreadReason, in moneyThreads: [MoneyThread]) -> Double {
        moneyThreads.reduce(into: 0) { $0 += $1.reason == threadReason.rawValue ? $1.amount : 0.0 }
    }
}
