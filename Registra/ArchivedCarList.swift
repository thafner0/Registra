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
        List(cars) { car in
            NavigationLink(value: car) {
                CarCell(car: car)
                    .swipeActions(edge: .leading) {
                        Button("Unarchive Car", systemImage: "eye.fill", role: .destructive) {
                            car.isArchived = false
                        }
                        .tint(.green)
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
        .navigationDestination(for: Car.self) { car in
            CarDetail(car: car)
        }
    }
}

#Preview {
    NavigationStack {
        ArchivedCarList()
    }
}
