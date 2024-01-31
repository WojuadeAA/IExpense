//
//  AddExpenseView.swift
//  IExpense
//
//  Created by Wojuade Abdul Afeez on 17/01/2024.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses : Expenses 

    let types = ["Buisness", "Personal"]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                TextField("Amount", value: $amount, format:.currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                       
                        dismiss()
                        
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        print(item)
                        expenses.items.append(item)
                        dismiss()
                        }
                }
                
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    
    AddExpenseView(expenses: Expenses())
}
