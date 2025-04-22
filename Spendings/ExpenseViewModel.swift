//
//  ExpenseViewModel.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
// View model for the Expenses

import Foundation
import SwiftUI

class ExpenseViewModel: ObservableObject {
    //@Published = when this array changes, Swift views get notified
    @Published var expenses: [Expense] = []
    @Published var categories: [ExpenseCategory] =
    [
        ExpenseCategory(name: "Groceries"),
        ExpenseCategory(name: "Medicine"),
        ExpenseCategory(name: "Hobbies")
    ]
    
    // group the expenses, calculate total amount
    var groupedExpenses: [(String, Double)] {
        Dictionary(grouping: self.currentMonthExpenses, by: { $0.category })
            .map{ (category, items) in
                (category, items.reduce(0) { $0 + $1.amount })
            }
    }
    
    // return only expenses of current month (as an array)
    var currentMonthExpenses: [Expense] {
        let calender = Calendar.current
        
        return expenses.filter{    // filter the expenses array with just expenses with current month
            calender.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
    }
    
    func addNewExpense(title: String, amount: Double, category: String){
        let newExpense = Expense(title: title, amount: amount, category: category, date: Date())
        expenses.append(newExpense)
    }
    
    func addNewCategory(name: String){
        let newCategory = ExpenseCategory(name: name)
        categories.append(newCategory)
    }
    
}
