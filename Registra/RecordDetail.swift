//
//  RecordDetail.swift
//  Registra
//
//  Created by Trevor Hafner on 26/12/2024.
//

import SwiftUI

struct RecordDetail: View {
    let record: Record?
    @State var start: Date = Date().addingTimeInterval(-600)
    @State var end: Date = Date()
    @State var drivenDistance: Double?
    @State var daylightCondition: DaylightCondition = .day
    @State var weatherConditions = ""
    @State var car = ""
    @State var notes = ""
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            DatePicker("Start", selection: $start, in: ...end)
            DatePicker("End", selection: $end, in: start...)
            TextField("Driven Distance", value: $drivenDistance, format: .number)
            Picker("Daylight Condition", selection: $daylightCondition) {
                Text("Day").tag(DaylightCondition.day)
                Text("Night").tag(DaylightCondition.night)
            }
            .pickerStyle(.segmented)
            TextField("Weather Conditions", text: $weatherConditions, axis: .vertical)
            TextField("Car", text: $car)
            
            TextField("Notes", text: $notes, axis: .vertical)
        }
        .navigationTitle(record == nil ? "New Record" : "Record Detail")
        .onAppear {
            if let record {
                start = record.start
                end = record.end
                drivenDistance = record.drivenDistance
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
                        record.start = start
                        record.end = end
                        record.drivenDistance = drivenDistance
                        record.daylightCondition = daylightCondition
                        record.weatherConditions = weatherConditions
                        record.car = car
                        record.notes = notes
                    } else {
                        let new = Record(start: start, end: end, drivenDistance: drivenDistance, daylightCondition: daylightCondition, weatherConditions: weatherConditions, car: car, notes: notes)
                        context.insert(new)
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordDetail(record: nil)
    }
}
