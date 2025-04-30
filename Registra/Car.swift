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
    var id = UUID()
    var make: String
    var model: String?
    var year: Int?
    var trimLevel: String?
    
    var name: String
    
    init(name: String, make: String, model: String? = nil, year: Int? = nil, trimLevel: String? = nil) {
        self.make = make
        self.model = model
        self.year = year
        self.trimLevel = trimLevel
        
        self.name = name
    }
}
