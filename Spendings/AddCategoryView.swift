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
    
    // if User did not input valid Category
    @State var errorMessage = ""
    @State var showMessage = false
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Category Name: ", text: $categoryName)
            }
            .onChange(of: categoryName){ _ in
                showMessage = false
            }
            .navigationTitle("Add new Category")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("save"){
                        if !categoryName.isEmpty{
                            Expenses.addNewCategory(name: categoryName)
                            dismiss()
                        }else{
                            errorMessage = "User did not input a Category!"
                            showMessage = true
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
        if showMessage{
            Text(errorMessage)
                .foregroundColor(.red)
        }
    }
}
