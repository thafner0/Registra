//
//  CarList.swift
//  Registra
//
//  Created by Trevor Hafner on 30/04/2025.
//

import SwiftUI
import SwiftData

struct CarList: View {
    @Query var cars: [Car]
    @State var showNewCardSheet = false
    
    var body: some View {
        List(cars) { car in
            NavigationLink(value: car) {
                CarCell(car: car)
            }
        }
        .navigationTitle("Cars")
        .toolbar {
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
    }
}

#Preview {
    NavigationStack {
        CarList()
            .modelContainer(try! ModelContainer(for: Car.self, configurations: .init(isStoredInMemoryOnly: true)))
    }
}
