//
//  Record.swift
//  Registra
//
//  Created by Trevor Hafner on 25/12/2024.
//

import Foundation
import SwiftData

@Model
final class Record: Identifiable {
    var id = UUID()
    var start: Date
    var end: Date
    var drivenDistance: Double?
    var daylightCondition: DaylightCondition
    var weatherConditions: String
    var car: String
    var notes: String
    
    init(start: Date, end: Date, drivenDistance: Double?, daylightCondition: DaylightCondition, weatherConditions: String, car: String, notes: String) {
        self.start = start
        self.end = end
        self.drivenDistance = drivenDistance
        self.daylightCondition = daylightCondition
        self.weatherConditions = weatherConditions
        self.car = car
        self.notes = notes
    }
}

enum DaylightCondition: Codable, Hashable {
    case day
    case night
}
