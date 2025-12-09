//
//  RecordDetail.swift
//  Registra
//
//  Created by Trevor Hafner on 26/12/2024.
//

import SwiftUI
import SwiftData

struct RecordDetail: View {
    @Query(filter: #Predicate<Car>{ car in !car.isArchived }, sort: \Car.name, animation: .default)
    var cars: [Car]
    
    let record: Record?
    @State var start: Date?
    @State var end: Date?
    @State var rawDrivenDistance: Double?
    var convertedDrivenDistance: Double? {
        record?.convertDrivenDistance(from: rawDrivenDistance)
    }
    @State var daylightCondition: DaylightCondition = .day
    @State var weatherConditions = ""
    @State var car: Car? = nil
    @State var notes = ""
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            if record != nil, let start = Binding($start), let end = Binding($end) {
                ExistingRecordTemporalInformation(start: start, end: end)
            } else {
                NewRecordTermporalInfromation(start: $start, end: $end)
            }
            
            TextField("Driven Distance", value: $rawDrivenDistance, format: .number)
            if let convertedDrivenDistance {
                LabeledContent("Driven Distance (converted)", value: convertedDrivenDistance.formatted())
            }
            Picker("Daylight Condition", selection: $daylightCondition) {
                Text("Day").tag(DaylightCondition.day)
                Text("Night").tag(DaylightCondition.night)
            }
            .pickerStyle(.segmented)
            TextField("Weather Conditions", text: $weatherConditions, axis: .vertical)
            Picker("Car", selection: $car) {
                if record == nil {
                    Text("Select Car").tag(Car?.none)
                }
                ForEach(cars) { car in
                    Text(car.name).tag(car, includeOptional: true)
                }
            }
            
            TextField("Notes", text: $notes, axis: .vertical)
        }
        .navigationTitle(record == nil ? "New Record" : "Record Detail")
        .onAppear {
            if let record {
                start = record.start
                end = record.end
                rawDrivenDistance = record.rawDrivenDistance
                daylightCondition = record.daylightCondition
                weatherConditions = record.weatherConditions
                car = record.car
                notes = record.notes
            }
        }
        .toolbar {
            if record == nil {
                ToolbarItem(id: "cancel", placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            ToolbarItem(id: "commit", placement: .confirmationAction) {
                Button("Save") {
                    if let record {
                        record.start = start!
                        record.end = end!
                        record.rawDrivenDistance = rawDrivenDistance
                        record.daylightCondition = daylightCondition
                        record.weatherConditions = weatherConditions
                        record.car = car!
                        record.notes = notes
                    } else {
                        let new = Record(start: start!, end: end!, drivenDistance: rawDrivenDistance, daylightCondition: daylightCondition, weatherConditions: weatherConditions, car: car!, notes: notes)
                        context.insert(new)
                    }
                    dismiss()
                }
                .disabled(car == nil && start == nil && end == nil)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordDetail(record: nil)
    }
}

#Preview {
    NavigationStack {
        RecordDetail(record: Record(start: Date(timeIntervalSinceNow: Double.random(in: (-2500)...(-120))), end: Date(timeIntervalSinceNow: Double.random(in: (120)...(2500))), drivenDistance: Double.random(in: 0.1...230), daylightCondition: .day, weatherConditions: "The fog of despair", car: Car(name: "The Excellent", make: "Jeremy Clarkson", model: "The Excellent", trimLevel: "N/A", odometerUnits: .miles), notes: ""))
    }
}
