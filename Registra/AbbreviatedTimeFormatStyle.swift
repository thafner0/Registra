//
//  AbbreviatedTimeFormatStyle.swift
//  Registra
//
//  Created by Trevor Hafner on 11/23/25.
//

import Foundation
import RegexBuilder

struct AbbreviatedTimeFormatStyle: ParseableFormatStyle {
    var parseStrategy: Strategy = Strategy()
    
    func format(_ value: Date) -> String {
        let innerStyle = Date.FormatStyle()
            .hour(.defaultDigits(amPM: .narrow))
            .minute(.twoDigits)
        
        return innerStyle.format(value)
    }
    
    typealias FormatInput = Date
    
    typealias FormatOutput = String
    
    struct Strategy: ParseStrategy {
        func parse(_ value: String) throws -> Date {
            let minuteRef = Reference(Int.self)
            let hourRef = Reference(Int?.self)
            let regex = Regex {
                Optionally(.reluctant) {
                    TryCapture(as: hourRef) {
                        Repeat(1...2) {
                            .digit
                        }
                    } transform: {
                        guard let number = Int($0) else {
                            throw ParseError.invalidNumericFormat
                        }
                        
                        guard (0...23).contains(number) else {
                            throw ParseError.hourOutOfRange(invalidValue: number)
                        }
                        return number
                    }
                    ":"
                }
                Capture(as: minuteRef) {
                    Repeat(.digit, count: 2)
                } transform: {
                    guard let number = Int($0) else {
                        throw ParseError.invalidNumericFormat
                    }
                    
                    guard (0...59).contains(number) else {
                        throw ParseError.minuteOutOfRange(invalidValue: number)
                    }
                    return number
                }
            }
            
            guard let match = try regex.wholeMatch(in: value) else {
                throw ParseError.invalidNumericFormat
            }
            let hour = match[hourRef]
            let minute = match[minuteRef]
            
            let dateComponentMask = DateComponents(hour: hour, minute: minute)
            let calendar = Calendar.autoupdatingCurrent
            
            guard let candidateDate = calendar.nextDate(after: Date(), matching: dateComponentMask, matchingPolicy: .nextTimePreservingSmallerComponents, direction: .backward) else {
                throw ParseError.candidateDateNotFound
            }
            return candidateDate
        }
        
        typealias ParseInput = String
        typealias ParseOutput = Date
    }
    
    enum ParseError: Error {
        case invalidNumericFormat
        case minuteOutOfRange(invalidValue: Int)
        case hourOutOfRange(invalidValue: Int)
        case candidateDateNotFound
    }
}
