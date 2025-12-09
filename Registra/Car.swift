//
//  Car.swift
//  Registra
//
//  Created by Trevor Hafner on 31/03/2025.
//

import Foundation
import SwiftData

@Model
final class Car: Identifiable {
    @Attribute(.unique, .preserveValueOnDeletion) var name: String
    var isArchived: Bool = false
    
    var make: String
    var model: String
    var year: Int?
    var trimLevel: String
    
    var odometerUnits: DistanceUnit
    
    @Relationship(deleteRule: .cascade, inverse: \Record.car)
    var records: [Record] = []
    
    init(name: String, make: String, model: String, year: Int? = nil, trimLevel: String, odometerUnits: DistanceUnit) {
        self.make = make
        self.model = model
        self.year = year
        self.trimLevel = trimLevel
        
        self.name = name
        
        self.odometerUnits = odometerUnits
    }
    
    var description: String {
        return [year?.formatted(.number.grouping(.never)), make, model, trimLevel].compactMap({ $0 }).joined(separator: " ")
    }
}

enum DistanceUnit: Codable, CaseIterable, Hashable {
    case kilometers
    case miles
    
    var name: String {
        switch self {
        case .kilometers: return "kilometers"
        case .miles: return "miles"
        }
    }
    
    var unit: UnitLength {
        switch self {
        case .kilometers: return .kilometers
        case .miles: return .miles
        }
    }
}
