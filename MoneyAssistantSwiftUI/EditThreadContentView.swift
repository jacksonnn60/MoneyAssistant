//
//  EditThreadContentView.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 17/06/2022.
//

import SwiftUI

struct EditThreadContentView: View {
    
    var moneyThread: MoneyThread?
    
    // MARK: - Body
    
    var body: some View {
        Text(moneyThread?.title ?? "--")
        Text("$\(moneyThread?.amount ?? 0.0)")
    }
}

//struct EditThreadContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditThreadContentView(moneyThread: )
//    }
//}
