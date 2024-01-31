
//
//  ContentView.swift
//  IExpense
//
//  Created by Wojuade Abdul Afeez on 21/12/2023.
//
import SwiftUI


struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddExpenseView = false
    private var buisnessExpenses: [ExpenseItem] {
        expenses.items.filter({expenseItem in
            expenseItem.type == "Buisness"
        })
    }
    private var personalExpenses : [ExpenseItem] {
        expenses.items.filter({ExpenseItem in
            ExpenseItem.type == "Personal"
        })
    }
    var body: some View {
        NavigationStack{
            List{
             
                Section("Personal Expenses"){
                    ForEach(personalExpenses){ item in
                        HStack {
                               VStack(alignment: .leading) {
                                   Text(item.name)
                                       .font(.headline)
                                   Text(item.type)
                               }

                               Spacer()
                            Text(item.amount, format:.currency(code: "USD"))
                           }
                    }.onDelete(perform: removeItem)
               
                }
                Section("Buisness Expenses"){
                    ForEach(buisnessExpenses){ item in
                        HStack {
                               VStack(alignment: .leading) {
                                   Text(item.name)
                                       .font(.headline)
                                   Text(item.type)
                               }

                               Spacer()
                            Text(item.amount, format:.currency(code: "USD"))
                           }
                    }.onDelete(perform: removeItem)
               
                }
                 
            }.navigationTitle("Expenses List")
                .toolbar{
                    NavigationLink{
                        AddExpenseView(expenses: expenses)
                    } label: {
                        Image(systemName: "plus")
                      }
                 
                      
                     
                    
                }
        }
        .sheet(isPresented: $showAddExpenseView)  {
            AddExpenseView(expenses: expenses)
        }
    }
    
    func removeItem(at offset : IndexSet)  {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

