//
//  Category.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//

import Foundation

// identifiable protocoll for lists/collections
// hashable = allows the struct to be stored in collections
struct ExpenseCategory: Identifiable, Codable, Hashable {
    var id = UUID()      // unique identifier is created and assigned to id
    var name: String
    
    // customized constructor
    // creates a new UUID or not, depends if the loaded category from JSON already has one
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
