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
    })
    var cars: [Car]
    
    @State var showNewCardSheet = false
    @State var showArchivedCars = false
    
    var body: some View {
        List(cars) { car in
            NavigationLink(value: car) {
                CarCell(car: car)
                    .swipeActions(edge: .leading) {
                        Button("Archive", systemImage: "eye.slash") {
                            car.isArchived = true
                        }
                        .tint(.blue)
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
    }
}

#Preview {
    NavigationStack {
        CarList()
            .modelContainer(try! ModelContainer(for: Car.self, configurations: .init(isStoredInMemoryOnly: true)))
    }
}
