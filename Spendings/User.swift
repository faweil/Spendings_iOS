//
//  User.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/24/25.
//

import Foundation

struct User: Codable, Identifiable{
    var id = UUID()
    var username: String
    var password: String
}
