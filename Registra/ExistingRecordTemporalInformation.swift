//
//  ExistingRecordTemporalInformation.swift
//  Registra
//
//  Created by Trevor Hafner on 11/23/25.
//

import SwiftUI

struct ExistingRecordTemporalInformation: View {
    @Binding var start: Date
    @Binding var end: Date
    
    var body: some View {
        DatePicker("Start", selection: $start, in: ...end)
        DatePicker("End", selection: $end, in: start...)
    }
}

#Preview {
    @Previewable @State var start: Date = Date.init(timeIntervalSinceNow: Double.random(in: (-2500)...(-120)))
    @Previewable @State var end: Date = Date.init(timeIntervalSinceNow: Double.random(in: (120)...(2500)))
    
    
    ExistingRecordTemporalInformation(start: $start, end: $end)
}
