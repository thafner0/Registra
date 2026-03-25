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
    var start: Date
    var end: Date
    var rawDrivenDistance: Double?
    var convertedDrivenDistance: Double? {
        convertDrivenDistance(from: rawDrivenDistance)
    }
    var daylightCondition: DaylightCondition
    var weatherConditions: String
    var notes: String
    
    var car: Car
    
    init(start: Date, end: Date, drivenDistance: Double?, daylightCondition: DaylightCondition, weatherConditions: String, car: Car, notes: String) {
        self.start = start
        self.end = end
        self.rawDrivenDistance = drivenDistance
        self.daylightCondition = daylightCondition
        self.weatherConditions = weatherConditions
        self.car = car
        self.notes = notes
    }
    
    func convertDrivenDistance(from rawDrivenDistance: Double?) -> Double? {
        guard let rawDrivenDistance else { return nil }
        let unit: UnitLength
        switch Locale.autoupdatingCurrent.measurementSystem {
        case .metric:
            unit = .kilometers
        case .uk, .us:
            unit = .miles
        default:
            // TODO: emit an error log message to indicate that an unexpected measurement system was found
            unit = .kilometers
        }
        return unit.converter.value(fromBaseUnitValue: car.odometerUnits.unit.converter.baseUnitValue(fromValue: rawDrivenDistance))
    }
}

enum DaylightCondition: Codable, Hashable {
    case day
    case night
}
