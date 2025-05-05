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
    
    var name: String
    
    init(name: String, make: String, model: String, year: Int? = nil, trimLevel: String) {
        self.make = make
        self.model = model
        self.year = year
        self.trimLevel = trimLevel
        
        self.name = name
    }
    
    var description: String {
        return [year?.formatted(.number.grouping(.never)), make, model, trimLevel].compactMap({ $0 }).joined(separator: " ")
    }
}
