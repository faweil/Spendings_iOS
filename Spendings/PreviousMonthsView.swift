//
//  PreviousMonthsView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/27/25.
//

import SwiftUI

struct PreviousMonthsView: View {
    @ObservedObject var Expenses: ExpenseViewModel
    @Environment(\.dismiss) var dismiss

    // todays month and year
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedYear = Calendar.current.component(.year, from: Date())

    private let months = Array(1...12)
    private let years: [Int] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return (currentYear-5 ... currentYear).reversed() // (2020 ... 2025). reversed()
    }()
    
    // displaying the year without comma
    let yearFormatted: NumberFormatter = {
        let format = NumberFormatter()
        format.numberStyle = .none
        return format
    }()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Picker("Month", selection: $selectedMonth){
                        ForEach(months, id: \.self){ month in
                            Text(DateFormatter().monthSymbols[month-1]).tag(month)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("Year", selection: $selectedYear){
                        ForEach(years, id: \.self){ year in
                            Text(yearFormatted.string(from: NSNumber(value: year)) ?? "\(year)").tag(year)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                .padding()
                
                
                let filteredExpenses = Expenses.filterExpensesByMonth(month: selectedMonth, year: selectedYear)
                
                
                
                if filteredExpenses.isEmpty{
                    Text("No spendings found for the selected month!")
                        .foregroundColor(.secondary)
                        .padding()
                } else{
                    List(filteredExpenses) { expense in
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
                Spacer()
    
            }
            .navigationTitle("Past Spendings")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("close"){
                        dismiss()
                    }
                }
            }
        }
    }
}







struct PreviousMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousMonthsView(Expenses: ExpenseViewModel(userID: UUID()))
    }
}
