//
//  NewRecordTermporalInfromation.swift
//  Registra
//
//  Created by Trevor Hafner on 11/23/25.
//

import SwiftUI

struct NewRecordTermporalInfromation: View {
    @Binding var start: Date?
    @Binding var end: Date?
    
    private let style = AbbreviatedTimeFormatStyle()
    
    var body: some View {
        TextField("Start", value: $start, format: style)
        TextField("End", value: $end, format: style)
    }
}

#Preview {
    @Previewable @State var start: Date? = Date.init(timeIntervalSinceNow: Double.random(in: (-2500)...(-120)))
    @Previewable @State var end: Date? = Date.init(timeIntervalSinceNow: Double.random(in: (120)...(2500)))
    
    
    NewRecordTermporalInfromation(start: $start, end: $end)
}
