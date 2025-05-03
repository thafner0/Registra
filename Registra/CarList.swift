//
//  CarList.swift
//  Registra
//
//  Created by Trevor Hafner on 30/04/2025.
//

import SwiftUI
import SwiftData

struct CarList: View {
    @Query(filter: #Predicate<Car> { car in
        !car.isArchived
    }, sort: \Car.name, animation: .default)
    var cars: [Car]
    @Environment(\.modelContext) var context
    
    @State var showNewCardSheet = false
    @State var showArchivedCars = false
    
    @State var carBeingDeleted: Car? = nil
    @State var showDeletionConfirmation = false
    
    
    var body: some View {
        List(cars) { car in
            NavigationLink(value: car) {
                CarCell(car: car)
                    .swipeActions(edge: .leading) {
                        Button("Archive", systemImage: "eye.slash", role: .destructive) {
                            car.isArchived = true
                        }
                        .tint(.blue)
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash") {
                            carBeingDeleted = car
                            showDeletionConfirmation = true
                        }
                        .tint(.red)
                    }
            }
        }
        .navigationTitle("Cars")
        .toolbar {
            Button("Show Archived Cars", systemImage: "archivebox") {
                showArchivedCars = true
            }
            Button("Add", systemImage: "plus") {
                showNewCardSheet = true
            }
        }
        .sheet(isPresented: $showNewCardSheet) {
            NavigationStack {
                CarDetail(car: nil)
            }
        }
        .navigationDestination(for: Car.self) { car in
            CarDetail(car: car)
        }
        .sheet(isPresented: $showArchivedCars) {
            NavigationStack {
                ArchivedCarList()
            }
        }
        .alert("Delete Car?", isPresented: $showDeletionConfirmation, presenting: carBeingDeleted) { car in
            Button("Cancel", role: .cancel, action: {})
            Button("Delete", role: .destructive) {
                context.delete(car)
                try! context.save()
            }
        } message: { car in
            Text("Are you sure you want to delete '\(car.name)'?\nDeleting a car will also delete all records associated with it.")
        }

    }
}

#Preview {
    NavigationStack {
        CarList()
            .modelContainer(try! ModelContainer(for: Car.self, configurations: .init(isStoredInMemoryOnly: true)))
    }
}
