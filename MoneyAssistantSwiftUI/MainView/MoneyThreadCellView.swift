//
//  MainScreenListView.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import SwiftUI
import AudioToolbox

enum MoneyCellEventType {
    case deleteDidSwiped
    case editDidSwiped
    case cellDidTap
}

struct MoneyThreadCellView: View {
    var moneyThread: MoneyThread
    
    var cellAction: ((MoneyCellEventType) -> ())?
    
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
            
            if let info = moneyThread.info {
                Text(info)
                    .font(.footnote.italic())
                    .multilineTextAlignment(.center)
            }
            
        }
        .onTapGesture {
            cellAction?(.cellDidTap)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                cellAction?(.editDidSwiped)
                
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.gray)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                cellAction?(.deleteDidSwiped)
                
                AudioServicesPlaySystemSound(SystemSound.delete.rawValue)
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            .tint(.red)
        }
    }
}

enum SystemSound: UInt32 {
    case whistle = 1016
    case buttonPress = 1421
    case train = 1023
    case delete = 1018
    case haptic = 1102
}
