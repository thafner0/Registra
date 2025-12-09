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
    @State var odometerUnits: DistanceUnit = .kilometers
    
    var cannotContinue: Bool {
        make.isEmpty || name.isEmpty
    }
    
    var body: some View {
        Form {
            Section(header: Text("Display Name"), footer: Text("Inputting a display name that already belongs to another car will result in the below details overwriting the existing details.")) {
                TextField("Name", text: $name, prompt: Text("eg: John's Car (required)"))
            }
            
            Section(header: Text("Car Details")) {
                TextField("Year", value: $year, format: .number.grouping(.never))
                    .keyboardType(.numberPad)
                TextField("Make (required)", text: $make)
                TextField("Model", text: $model)
                TextField("Trim Level", text: $trimLevel)
                
                Picker("Odometer Distance Unit", selection: $odometerUnits) {
                    ForEach(DistanceUnit.allCases, id: \.self) { unit in
                        Text(unit.name)
                    }
                }
            }
        }
        .navigationTitle(car != nil ? "Edit Car" : "New Car")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let car {
                        car.make = make
                        car.name = name
                        
                        car.model = model
                        car.trimLevel = trimLevel
                        
                        car.year = year
                        
                        car.odometerUnits = odometerUnits
                    } else {
                        let newCar = Car(name: name, make: make, model: model, year: year, trimLevel: trimLevel, odometerUnits: odometerUnits)
                        context.insert(newCar)
                    }
                    dismiss()
                }
                .disabled(cannotContinue)
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
        self.odometerUnits = car?.odometerUnits ?? .kilometers
    }
}

#Preview {
    NavigationStack {
        CarDetail(car: Car(name: "Carrio", make: "Toyota", model: "Corolla", year: 2010, trimLevel: "SE", odometerUnits: .miles))
    }
}
