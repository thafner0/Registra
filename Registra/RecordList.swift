//
//  RecordList.swift
//  Registra
//
//  Created by Trevor Hafner on 26/12/2024.
//

import SwiftUI
import SwiftData

struct RecordList: View {
    @Query private var records: [Record]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List {
            ForEach(records) { record in
                RecordCell(record: record)
            }
            .onDelete(perform: deleteItems(offsets:))
        }
        .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
    }

    private func addItem() {
        withAnimation {
            let newItem = Record(start: Date(), end: Date().addingTimeInterval(60), distance: 0, lightingCondition: .day, weatherConditions: "", car: "")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(records[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordList()
    }
    .modelContainer(for: [Record.self], inMemory: true)
}
