//
//  File.swift
//  IExpense
//
//  Created by Wojuade Abdul Afeez on 17/01/2024.
//
import Foundation
import Observation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name : String
    let type: String
    let amount : Double
}


@Observable
class Expenses {
     static let itemsKey =  "items"
    
    var items = [ExpenseItem](){
        didSet{
            if let encodedItems = try? JSONEncoder().encode(items){
                UserDefaults.standard.setValue(encodedItems, forKey: Expenses.itemsKey)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Expenses.itemsKey){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
                
            }
        }
        items = []
    }
}

