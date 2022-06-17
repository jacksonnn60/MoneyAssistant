//
//  MoneyThreadCDController.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 16/06/2022.
//

import CoreData
import SwiftUI
import AudioToolbox

protocol IMoneyThreadCDController: ObservableObject {
    var moneyThreads: [MoneyThread] { get }
    
    func fetchData()
    func save(title: String, description: String, amount: Double, reason: MoneyThreadReason)
    func delete(_ moneyThread: MoneyThread)
}

final class MoneyThreadCDController: IMoneyThreadCDController {
    
    private let container = NSPersistentContainer(name: "DataModel")
    
    private lazy var context = container.viewContext
    
    // MARK: - Observables
    
    @Published var moneyThreads: [MoneyThread] = []
    
    // MARK: - Init
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core date failed to load \(error.localizedDescription).")
            }
        }
    }
    
    // MARK: - Main Actions
    
    func fetchData() {
        let request = NSFetchRequest<MoneyThread>(entityName: "MoneyThread")
        
        moneyThreads = (try? context.fetch(request)) ?? []
    }
    
    func save(title: String, description: String = "", amount: Double, reason: MoneyThreadReason) {
        
        let moneyThread_ = MoneyThread(context: context)
        
        moneyThread_.id = UUID()
        moneyThread_.amount = amount
        moneyThread_.info = description.isEmpty ? nil : description
        moneyThread_.reason = reason.rawValue
        moneyThread_.date = Date()
        moneyThread_.title = title
                
        refreshThreads()
    }
    
    func delete(_ moneyThread: MoneyThread) {
        context.delete(moneyThread)
        
        refreshThreads()
    }
    
    private func refreshThreads() {
        try? context.save()
        
        fetchData()
    }
    
}
