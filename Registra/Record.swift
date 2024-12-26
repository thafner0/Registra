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
    var distance: Double
    var lightingCondition: DaylightCondition
    var weatherConditions: String
    var car: String
    
    init(start: Date, end: Date, distance: Double, daylightCondition: DaylightCondition, weatherConditions: String, car: String) {
        self.start = start
        self.end = end
        self.distance = distance
        self.lightingCondition = daylightCondition
        self.weatherConditions = weatherConditions
        self.car = car
    }
}

enum DaylightCondition: Codable, Hashable {
    case day
    case night
}
