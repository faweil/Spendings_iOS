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
    
    private let expenseFileName = "expenses.json"
    private let categoryFileName = "category.json"
    
    // load all expenses from JSON
    init(){
        loadExpense()
        loadCategory()
    }
    
    func loadCategory(){
        let path = getDirectory().appendingPathComponent(categoryFileName)
        print("Thats the URL: \(path)")
        do {
            let data = try Data(contentsOf: path)
            categories = try JSONDecoder().decode([ExpenseCategory].self, from: data)
        } catch{
            print("no saved categories, or failed to load")
        }
    }
    
    func loadExpense(){
        let path = getDirectory().appendingPathComponent(expenseFileName)
        print("Thats the URL: \(path)")
        do {
            let data = try Data(contentsOf: path)
            expenses = try JSONDecoder().decode([Expense].self, from: data)
        } catch{
            print("no saved expenses, or failed to load")
        }
    }
    
    func saveExpense(){
        let path = getDirectory().appendingPathComponent(expenseFileName)
        do {
            let data = try JSONEncoder().encode(expenses)
            try data.write(to: path)
        } catch{
            print("error saving expenses")
        }
    }
    
    func saveCategory(){
        let path = getDirectory().appendingPathComponent(categoryFileName)
        do {
            let data = try JSONEncoder().encode(categories)
            try data.write(to: path)
        } catch{
            print("error saving categories")
        }
    }
    
    // returns path from user's Documents directory
    // .documentDirectory = here store files which user might access
    func getDirectory() -> URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // group the expenses, calculate total amount
    var groupedExpenses: [(String, Double)] {
        Dictionary(grouping: self.currentMonthExpenses, by: { $0.category })
            .map{ (category, items) in
                (category, items.reduce(0) { $0 + $1.amount })
            }
    }
    
    //total amount of spendings this month
    var totalExpense: Double {
        self.currentMonthExpenses.reduce(0) { $0 + $1.amount }
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
        saveExpense()
    }
    
    func addNewCategory(name: String){
        let newCategory = ExpenseCategory(name: name)
        categories.append(newCategory)
        saveCategory()
    }
    
}
