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
    
    var body: some View {
        Form {
            DatePicker("Start", selection: $start, in: ...end)
            DatePicker("End", selection: $end, in: start...)
        }
        .navigationTitle(record == nil ? "New Record" : "Record Detail")
    }
}

#Preview {
    NavigationStack {
        RecordDetail(record: nil)
    }
}
