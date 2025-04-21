//
//  Expense.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//

import Foundation

// identifiable protocoll for lists/collections
struct Expense: Identifiable {
    let id = UUID()          // unique identifier is created and assigned to id
    var title: String
    var amount: Double
    var category: String
    var date: Date
}


