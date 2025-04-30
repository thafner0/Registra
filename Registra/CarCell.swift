//
//  CarCell.swift
//  Registra
//
//  Created by Trevor Hafner on 30/04/2025.
//

import SwiftUI

struct CarCell: View {
    let car: Car
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            Text(car.name)
                .font(.headline)
            Text(car.description)
                .font(.caption)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CarCell(car: Car(name: "Carrio", make: "Toyota", model: "Corolla", year: 2010, trimLevel: "SE"))
}
