//
//  ArchivedCarList.swift
//  Registra
//
//  Created by Trevor Hafner on 03/05/2025.
//

import SwiftUI
import SwiftData

struct ArchivedCarList: View {
    @Query(filter: #Predicate<Car> { car in
        car.isArchived
    }, sort: \Car.name, animation: .default)
    var cars: [Car]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            if cars.isEmpty {
                Text("No Archived Cars")
                    .font(.title)
                    .foregroundStyle(.secondary)
            } else {
                List(cars) { car in
                    NavigationLink(value: car) {
                        CarCell(car: car)
                            .swipeActions(edge: .leading) {
                                Button("Unarchive Car", systemImage: "tray.and.arrow.up.fill", role: .destructive) {
                                    car.isArchived = false
                                }
                                .tint(.blue)
                            }
                    }
                }
                .navigationDestination(for: Car.self) { car in
                    CarDetail(car: car)
                }
            }
        }
        .navigationTitle("Archived Cars")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    dismiss()
                }
                .bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArchivedCarList()
    }
}
