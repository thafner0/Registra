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
    @State private var showAddRecordSheet = false
    
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
                Button {
                    showAddRecordSheet = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddRecordSheet) {
            NavigationStack {
                RecordDetail(record: nil)
            }
        }
        .navigationTitle("Records")
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
