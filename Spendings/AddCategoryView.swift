//
//  AddCategoryView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/20/25.
//

import SwiftUI

struct AddCategoryView: View{
    @ObservedObject var Expenses: ExpenseViewModel
    @Environment(\.dismiss) var dismiss

    @State private var categoryName = ""
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Category Name: ", text: $categoryName)
            }
            .navigationTitle("Add new Category")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("save"){
                        if !categoryName.isEmpty{
                            Expenses.addNewCategory(name: categoryName)
                            dismiss()
                        }else{
                            print("User did not input a new category name")
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
