//
//  CarDetail.swift
//  Registra
//
//  Created by Trevor Hafner on 31/03/2025.
//

import SwiftUI
import Foundation

struct CarDetail: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    let car: Car?
    
    @State var make: String
    @State var model: String
    @State var year: Int?
    @State var trimLevel: String
    
    @State var name: String
    
    var body: some View {
        Form {
            Section(header: Text("Display Name")) {
                TextField("Name", text: $name, prompt: Text("eg: John's Car"))
            }
            
            Section(header: Text("Car Details")) {
                TextField("Year", value: $year, format: .number.grouping(.never))
                    .keyboardType(.numberPad)
                TextField("Make", text: $make)
                TextField("Model", text: $model)
                TextField("Trim Level", text: $trimLevel)
            }
        }
        .navigationTitle(car != nil ? "Edit Car" : "New Car")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let car {
                        car.make = make
                        car.model = model
                        car.year = year
                        car.trimLevel = trimLevel
                        car.name = name
                    } else {
                        let newCar = Car(name: name, make: make, model: model, year: year, trimLevel: trimLevel)
                        context.insert(newCar)
                    }
                    dismiss()
                }
            }
            
            if car == nil {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(car: Car?) {
        self.car = car
        self.make = car?.make ?? ""
        self.model = car?.model ?? ""
        self.year = car?.year
        self.trimLevel = car?.trimLevel ?? ""
        self.name = car?.name ?? ""
    }
}

#Preview {
    NavigationStack {
        CarDetail(car: Car(name: "Carrio", make: "Toyota", model: "Corolla", year: 2010, trimLevel: "SE"))
    }
}
