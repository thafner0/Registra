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
    @Query private var items: [Record]

    var body: some View {
        NavigationSplitView {
            RecordList()
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Record.self, inMemory: true)
}
