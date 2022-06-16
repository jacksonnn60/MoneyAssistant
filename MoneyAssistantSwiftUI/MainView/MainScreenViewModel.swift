//
//  MainScreenViewModel.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI
import Combine

protocol IMainScreenViewModel: ObservableObject {
    var moneyThreads: [MoneyThread] { get }
        
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
