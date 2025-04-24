//
//  Expense.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//

import Foundation

// identifiable protocoll for lists/collections
struct Expense: Identifiable, Codable {
    var id = UUID()          // unique identifier is created and assigned to id
    var title: String
    var amount: Double
    var category: String
    var date: Date
    
    // customized constructor
    // creates a new UUID or not, depends if the loaded expense from JSON already has one
    init(id: UUID = UUID(), title: String, amount: Double, category: String, date: Date) {
        self.id = id
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
    }
}
