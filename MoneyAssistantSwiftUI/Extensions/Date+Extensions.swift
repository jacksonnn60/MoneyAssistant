//
//  Date+Extensions.swift
//  MoneyAssistantSwiftUI
//
//  Created by Jackson  on 14/06/2022.
//

import Foundation

enum DateFormat: String {
    case `default` = "MM/d/yy HH:mm"
}

extension TimeInterval {
    func convert(to dateFormat: DateFormat) -> String {
        Date(timeIntervalSince1970: self).convert(to: dateFormat)
    }
}

extension Date {
    func convert(to format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
