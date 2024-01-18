//
//  ContentView.swift
//  IExpense
//
//  Created by Wojuade Abdul Afeez on 21/12/2023.
//

import SwiftUI



struct DeletingItemsExampleView : View{
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View{
        VStack{
            List{
                ForEach(numbers, id:\.self){
                    Text("Row \($0)")
                }.onDelete(perform: delete)
            }
            
            Button("Add Number"){
                numbers.append(currentNumber)
                currentNumber += 1
            }
        }.toolbar{
            EditButton()
        }
        
        
    }
    func delete(at offsets: IndexSet)  {
        numbers.remove(atOffsets:  offsets)
    }
}

struct SecondView : View{
    @Environment(\.dismiss) var dismiss
    let name : String
    var body: some View{
        Text("Hello \(name)")
        Button("Dismiss"){
            dismiss()
        }
    }
}

struct UserDefaultExampleView : View{
    @AppStorage("tapCount") private var tapCount : Int = 0
    
    var body: some View{
        Button("Tap Count: \(tapCount)"){
            tapCount += 1
          }
    }
}

///Codable example
///
///
///

struct User : Codable {
     var firstName : String
     var  lastName : String
    
    
}
struct CodableExampleView : View {
   
    @State private var firstName = ""
    @State private var lastName = ""
    private var user : User {
        if !lastName.isEmpty && !firstName.isEmpty {
            return    User(firstName: firstName, lastName: lastName)
        }
  
        let userData = UserDefaults.standard.data(forKey: "userDat")
        let decoder = JSONDecoder()
        if  let user = try? decoder.decode(User.self, from: userData ?? Data()){
            return user
        }else{
            return User(firstName: "Error", lastName: "Error")
        }
        
        
    }
    var body: some View{
        
        Form{
            TextField( "First Name",text :$firstName)
            
            TextField( "Last Name",text :$lastName)
            
            Text("\(user.firstName) \(user.lastName)")
        }
            
            
        
        Button("Save user"){
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user){
                UserDefaults.standard.set(data, forKey: "userDat")
            }
        }
    }
}

struct ExamplesView: View {
    @State private var showingSecondView  = false
    var body: some View {
       
        NavigationStack {
            VStack(spacing: 50){

                
                CodableExampleView()
            
                UserDefaultExampleView()
        
                Button("Show Second View"){
                    
                    showingSecondView.toggle()
                }
    }
            
            .padding()
            .sheet(isPresented: $showingSecondView){
             SecondView(name: "Wojuade")
        }
        }
    }
}

struct ExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesView()
    }
}
