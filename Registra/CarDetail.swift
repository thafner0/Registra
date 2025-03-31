//
//  CarDetail.swift
//  Registra
//
//  Created by Trevor Hafner on 31/03/2025.
//

import SwiftUI
import Foundation

struct CarDetail: View {
    @State var registrationCountryCode = ""
    @State var registrationRegionCode = ""
    @State var registrationNumber = ""
    
    @State var make = ""
    @State var model = ""
    @State var year: Int?
    @State var trimLevel = ""
    
    @State var name = ""
    
    var body: some View {
        Form {
            Section(header: Text("Display Name")) {
                TextField("Name", text: $name, prompt: Text("eg: John's Car"))
            }
            
            Section(header: Text("Car Details")) {
                TextField("Make", text: $make)
                TextField("Model", text: $model)
                TextField("Year", value: $year, format: .number)
                TextField("Trim Level", text: $trimLevel)
            }
            
            Section(header: Text("Registration Information")) {
                TextField("Registration Country Code", text: $registrationCountryCode)
                TextField("Registration Region Code", text: $registrationRegionCode)
                TextField("Registration Number", text: $registrationNumber)
            }
        }
        .navigationTitle("Car Detail")
    }
}

#Preview {
    NavigationStack {
        CarDetail()
    }
}
