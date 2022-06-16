//
//  MainScreenListView.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI

struct MoneyThreadCellView: View {
    var moneyThread: MoneyThread
    var moneyThreadWasDeleted: EmptyClosure?
    
    private var reason: MoneyThreadReason {
        MoneyThreadReason(rawValue: moneyThread.reason ?? "moneyEarned") ?? .moneyEarned
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding([.top, .bottom])
                    .foregroundColor(
                        reason == .moneyEarned ? .accentColor : .red
                    )
                
                Text(moneyThread.title ?? "--")
                    .font(.system(.headline))
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    let amountOfMoneyString = "\(reason == .moneyEarned ?  "+" : "-") $\(String(format: "%.2f", moneyThread.amount).trimmingCharacters(in: .whitespaces))"
                    
                    Text(amountOfMoneyString).bold()
                    
                    Text("\(moneyThread.date?.convert(to: .default) ?? .init())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    moneyThreadWasDeleted?()
                } label: {
                    Label("Edit", systemImage: "trash.fill")
                }
                .tint(.red)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    moneyThreadWasDeleted?()
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
                .tint(.red)
            }
            
            if let info = moneyThread.info {
                Text(info)
            }
            
        }
    }
}

//struct MainScreenListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreenListView(moneyThread: MoneyThread(title: "Work", amount: 1500, reason: .moneyEarned))
//
//            .previewLayout(
//                PreviewLayout.sizeThatFits
//            )
//    }
//}
