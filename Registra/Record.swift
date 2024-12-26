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
    var lightingCondition: LightingCondition
    var weatherConditions: String
    var car: String
    
    init(start: Date, end: Date, distance: Double, lightingCondition: LightingCondition, weatherConditions: String, car: String) {
        self.start = start
        self.end = end
        self.distance = distance
        self.lightingCondition = lightingCondition
        self.weatherConditions = weatherConditions
        self.car = car
    }
}

enum LightingCondition: Codable {
    case day
    case night
}
