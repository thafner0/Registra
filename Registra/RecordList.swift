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
                NavigationLink {
                    RecordDetail(record: record)
                } label: {
                    RecordCell(record: record)
                }

            }
            .onDelete(perform: deleteRecords(offsets:))
        }
        .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addRecord) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
    }

    private func addRecord() {
        withAnimation {
            let newRecord = Record(start: Date(), end: Date().addingTimeInterval(60), distance: 0, daylightCondition: .day, weatherConditions: "", car: "")
            modelContext.insert(newRecord)
        }
    }

    private func deleteRecords(offsets: IndexSet) {
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
