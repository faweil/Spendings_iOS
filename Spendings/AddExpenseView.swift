//
//  AddExpenseView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/20/25.
//

import SwiftUI

struct AddExpenseView: View{
    //ObservedObject = keeps the view in sync w/ changes to ExpenseViewModel
    @ObservedObject var Expenses: ExpenseViewModel
    
    //view "verschwindet" if user presses save or cancel button
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory = ""

    var body: some View{
        NavigationView{
            Form{
                TextField("Title: ", text: $title)
                TextField("Amount: ", text: $amount)
                    .keyboardType(.decimalPad)
                
                Picker("Category: ", selection: $selectedCategory){
                    ForEach(Expenses.categories, id: \.self){ category in
                        Text(category.name).tag(category.name)
                    }
                }
                
            }
            .navigationTitle("Add new Expense")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("save"){
                        if let unwrappedAmount = Double(amount), !title.isEmpty, !selectedCategory.isEmpty{
                            Expenses.addNewExpense(title: title, amount: unwrappedAmount, category: selectedCategory)
                            dismiss()
                        }else{
                            print("User did not input valid Expense!")
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction){
                    Button("cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}
