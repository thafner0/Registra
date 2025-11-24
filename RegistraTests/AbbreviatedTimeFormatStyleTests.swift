//
//  AbbreviatedTimeFormatStyleTests.swift
//  AbbreviatedTimeFormatStyleTests
//
//  Created by Trevor Hafner on 25/12/2024.
//

import Testing
@testable import Registra
import Foundation

struct AbbreviatedTimeFormatStyleTests {
    
    let style = AbbreviatedTimeFormatStyle()
    let now = Date()
    let calendar = Calendar.current
    
    @Test func invalidMinuteForThisHour() async throws {
        print(now.formatted(date: .complete, time: .complete))
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        let rawAdjustedMinute = currentMinute + 7
        let (newHour, newMinute) = if rawAdjustedMinute >= 60 { (currentHour, rawAdjustedMinute % 60) } else { (currentHour - 1, rawAdjustedMinute) }
        
        let input = newMinute.formatted(.number.precision(.integerLength(2)))
        let expectedOutput = try #require(calendar.date(bySettingHour: newHour, minute: newMinute, second: 0, of: now))
        
        try #expect(style.parseStrategy.parse(input) == expectedOutput)
    }

    @Test func normalExpectedSituation() async throws {
        print(now.formatted(date: .complete, time: .complete))
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        let chosenMinute = Int.random(in: 0...currentMinute)
        let input = chosenMinute.formatted(.number.precision(.integerLength(2)))
        let expectedOutput = try #require(calendar.date(bySettingHour: currentHour, minute: chosenMinute, second: 0, of: now))
        
        try #expect(style.parseStrategy.parse(input) == expectedOutput)
    }
    
    @Test func invalidHourForThisDay() async throws {
        print(now.formatted(date: .complete, time: .complete))
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        let currentDay = calendar.component(.day, from: now)
        
        let chosenHour: Int
        let chosenDay: Int
        if currentHour == 23 {
            chosenHour = 0
            chosenDay = currentDay
        } else {
            chosenHour = currentHour + 1
            chosenDay = currentDay - 1
        }
        
        var expectedComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: now)
        expectedComponents.setValue(chosenDay, for: .day)
        expectedComponents.setValue(chosenHour, for: .hour)
        expectedComponents.setValue(0, for: .second)
        let expectedOutput = try #require(calendar.date(from: expectedComponents))
        
        let input = "\(chosenHour.formatted(.number.precision(.integerLength(2)))):\(currentMinute.formatted(.number.precision(.integerLength(2))))"
        
        try #expect(style.parseStrategy.parse(input) == expectedOutput)
    }
    
    @Test func standardHourMinuteSpecification() async throws {
        print(now.formatted(date: .complete, time: .complete))
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        
        let chosenHour = Int.random(in: 0...currentHour)
        var expectedComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: now)
        expectedComponents.setValue(chosenHour, for: .hour)
        expectedComponents.setValue(0, for: .second)
        let expectedOutput = try #require(calendar.date(from: expectedComponents))
        
        let input = "\(chosenHour.formatted(.number.precision(.integerLength(2)))):\(currentMinute.formatted(.number.precision(.integerLength(2))))"
        
        try #expect(style.parseStrategy.parse(input) == expectedOutput)
    }
}
