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
                
                Chart(Expenses.groupedExpenses, id: \.0){ category, total in
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Amount", total)
                    )
                    .foregroundStyle(by: .value("Category", category))
                    .annotation(position: .top) {
                        Text(total, format: .currency(code: "USD"))
                            .font(.caption)
                    }
                }
                .frame(height: 150)
                .padding()
                
                
                
                List(Expenses.currentMonthExpenses) { expense in
                    HStack {
                        VStack(alignment: .leading, spacing: 4){
                            Text(expense.title)
                                .font(.headline)
                        }

                        Text("$\(expense.amount, specifier: "%.2f")")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text(expense.category)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("💸 Spendings 💸")
                        .font(.title2.bold())
                        .foregroundColor(.accentColor)
                }
            }
            
        }
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
