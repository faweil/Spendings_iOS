//
//  Category.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//

import Foundation

// identifiable protocoll for lists/collections
// hashable = allows the struct to be stored in collections
struct ExpenseCategory: Identifiable, Hashable {
    let id = UUID()      // unique identifier is created and assigned to id
    var name: String
}
