//
//  MainPageView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//


import SwiftUI
import Charts

struct MainPageView: View {
    @EnvironmentObject var manageUser: ManageUser
    @StateObject private var Expenses: ExpenseViewModel

    init() {
        // Use a temporary dummy ViewModel to satisfy SwiftUI’s need for a default value.
        let dummyVM = ExpenseViewModel(userID: UUID())
        _Expenses = StateObject(wrappedValue: dummyVM)
    }
    
    var body: some View{
        if let user = manageUser.currentUser{
            MainPageViewWithUser(Expenses: ExpenseViewModel(userID: user.id))
        }else{
            EmptyView()
            Text("No user yet")
        }
    }
}


struct MainPageViewWithUser: View {
    @ObservedObject var Expenses: ExpenseViewModel
    @EnvironmentObject var manageUser: ManageUser
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
                                
                
                if Expenses.currentMonthExpenses.isEmpty {
                    VStack {
                        Text("No recorded spendings yet.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                        Text("Tap below to add your first expense!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }else{
                    Text("Total amount this month: $\(Expenses.totalExpense, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                    
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
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Log out"){
                        manageUser.logOut()
                    }
                    .foregroundColor(.red)
                }
            }
            
        }
    }
}

