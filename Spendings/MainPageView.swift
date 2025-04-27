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
        // will never display it, but swift wants a default value for @StateObject
        let defaultView = ExpenseViewModel(userID: UUID())
        _Expenses = StateObject(wrappedValue: defaultView)
    }
    
    var body: some View{
        if let user = manageUser.currentUser{
            MainPageViewWithUser(Expenses: ExpenseViewModel(userID: user.id))
        }else{
            EmptyView()
        }
    }
}


struct MainPageViewWithUser: View {
    @ObservedObject var Expenses: ExpenseViewModel
    @EnvironmentObject var manageUser: ManageUser
    
    @State private var showingAddExpensePopUp = false
    @State private var showingAddCategoryPopUp = false
    
    @State private var showPreviousMonths = false
    
    private func deleteExpense(index: IndexSet){
        // match ID from deleted Expense in UI with real one from List (then can delete its expense)
        let delete_ID = index.map{ Expenses.currentMonthExpenses[$0].id }
        
        if !delete_ID.isEmpty{
            Expenses.expenses.removeAll{ delete_ID.contains($0.id) }
            Expenses.saveExpense()
        }
        

    }
    
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
                    
                    List{
                        ForEach(Expenses.currentMonthExpenses) { expense in
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
                        .onDelete(perform: deleteExpense)
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
                Button("View previous Months spendings"){
                    showPreviousMonths = true
                }
                // pop up window for previous months
                .sheet(isPresented: $showPreviousMonths){
                    PreviousMonthsView(Expenses: Expenses)
                }
            }
            
            // pop up windows for category and expense
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

struct MainPageViewWithUser_Previews: PreviewProvider {
    static var previews: some View {
        MainPageViewWithUser(Expenses: ExpenseViewModel(userID: UUID()))
    }
}
