//
//  Animation+Extensions.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 15/06/2022.
//

import SwiftUI

extension Animation {
    static var customSpring: Animation? {
        .spring(response: 0.5, dampingFraction: 1, blendDuration: 0.75)
    }
}
