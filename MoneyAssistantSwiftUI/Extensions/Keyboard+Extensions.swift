//
//  Keyboard+Extensions.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 16/06/2022.
//

import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
