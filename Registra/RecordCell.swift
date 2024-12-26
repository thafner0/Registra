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
                Text("\(record.distance, format: .number) km in \(record.car)")
                    .font(.caption)
            }
            Spacer()
        }
    }
}


#Preview {
    let record = Record(start: Date(), end: Date().addingTimeInterval(600), distance: 7.4, daylightCondition: .day, weatherConditions: "Cloudy with heavy rain", car: "Dad's Car")
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
