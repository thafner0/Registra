//
//  ContentView.swift
//  Registra
//
//  Created by Trevor Hafner on 25/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            Tab("Records", systemImage: "tray.full.fill") {
                NavigationStack {
                    RecordList()
                }
            }
            
            Tab("Cars", systemImage: "car.2.fill") {
                NavigationStack {
                    CarList()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Record.self, Car.self], inMemory: true)
}
