//
//  OptionalFormatStyle.swift
//  Registra
//
//  Created by Trevor Hafner on 26/12/2024.
//

import Foundation

struct OptionalFormatStyle<F>: ParseableFormatStyle where F: ParseableFormatStyle, F.FormatOutput == String {
    let parseStrategy: Strategy
    let baseFormat: F
    
    func format(_ value: F.FormatInput?) -> String {
        if let value {
            return baseFormat.format(value)
        } else {
            return ""
        }
    }
    
    typealias FormatOutput = String
    typealias FormatInput = F.FormatInput?
    
    struct Strategy: ParseStrategy {
        let baseFormat: F
        
        func parse(_ input: String) throws -> F.FormatInput? {
            if input.isEmpty {
                return nil
            } else {
                return try baseFormat.parseStrategy.parse(input)
            }
        }
    }
    
    init(baseFormat: F) {
        self.baseFormat = baseFormat
        self.parseStrategy = Strategy(baseFormat: baseFormat)
    }
}
