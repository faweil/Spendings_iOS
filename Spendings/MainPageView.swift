//
//  MainPageView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//


import SwiftUI
import Charts

struct MainPageView: View {
    @StateObject private var Expenses = ExpenseViewModel()
    @State private var showingAddExpensePopUp = false
    @State private var showingAddCategoryPopUp = false
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Monthly Spending")
                    .font(.title)
                if #available(iOS 16.0, *){
                    Chart(Expenses.currentMonthExpenses){ expense in
                        BarMark(
                            x: .value("Category", expense.category),
                            y: .value("Amount", expense.amount)
                        )
                    }
                    .frame(height: 200)
                    .padding()
                }
                
                
                List(Expenses.currentMonthExpenses) { expense in
                    VStack(alignment: .leading) {
                        Text(expense.title)
                            .font(.headline)
                        Text("\(expense.amount, specifier: "%.2f") \(expense.category)")
                            .font(.subheadline)
                    }
                }
                
                HStack{
                    Button("Add new Expense"){
                        showingAddExpensePopUp = true
                    }
                    .padding()
                    
                    Button("Add new Category"){
                        showingAddCategoryPopUp = true
                    }
                    .padding()
                }
            }
            
            // pop up windows
            .sheet(isPresented: $showingAddExpensePopUp){
                AddExpenseView(Expenses: Expenses)
            }
            .sheet(isPresented: $showingAddCategoryPopUp){
                AddCategoryView(Expenses: Expenses)
            }
            .navigationTitle("Spendings")
            
        }
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
