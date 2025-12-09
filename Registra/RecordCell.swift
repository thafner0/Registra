//
//  RecordCell.swift
//  Registra
//
//  Created by Trevor Hafner on 25/12/2024.
//

import SwiftUI

struct RecordCell: View {
    let record: Record
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(record.start..<record.end, format: Date.IntervalFormatStyle(date: .complete, time: .shortened))
                Group {
                    if let drivenDistance = record.rawDrivenDistance {
                        Text("\(Measurement(value: drivenDistance, unit: record.car.odometerUnits.unit), format: .measurement(width: .abbreviated)) \(carText)")
                    } else {
                        Text(carText)
                    }
                }
                .font(.caption)
            }
            Spacer()
        }
    }
    
    private var carText: String {
        return "in \(record.car.name)"
    }
}


#Preview {
    let record = Record(start: Date(), end: Date().addingTimeInterval(600), drivenDistance: 7.4, daylightCondition: .day, weatherConditions: "Cloudy with heavy rain", car: Car(name: "Dad's Car", make: "Toyota", model: "", trimLevel: "", odometerUnits: .kilometers), notes: "")
    let locales = ["en_UK", "fr_FR"].map(Locale.init)
    
    List {
        Section(header: Text("Default Locale")) {
            RecordCell(record: record)
        }
        
        ForEach(locales, id: \.identifier) { locale in
            Section(header: Text(Locale.autoupdatingCurrent.localizedString(forIdentifier: locale.identifier) ?? "Error"), footer: Text(locale.identifier)) {
                RecordCell(record: record)
                    .environment(\.locale, locale)
            }
        }
    }
}
