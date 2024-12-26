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
    @State var daylightCondition: DaylightCondition = .day
    @State var weatherConditions = ""
    @State var car = ""
    
    var body: some View {
        Form {
            DatePicker("Start", selection: $start, in: ...end)
            DatePicker("End", selection: $end, in: start...)
            Picker("Daylight Condition", selection: $daylightCondition) {
                Text("Day").tag(DaylightCondition.day)
                Text("Night").tag(DaylightCondition.night)
            }
            .pickerStyle(.segmented)
            TextField("Weather Conditions", text: $weatherConditions)
            TextField("Car", text: $car)
        }
        .navigationTitle(record == nil ? "New Record" : "Record Detail")
        .onAppear {
            if let record {
                start = record.start
                end = record.end
                daylightCondition = record.lightingCondition
                weatherConditions = record.weatherConditions
                car = record.car
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordDetail(record: nil)
    }
}
