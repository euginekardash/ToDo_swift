//
//  ContentView.swift
//  Taks
//
//  Created by Taqtile on 16.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ToDo.isCompleted) private var toDos: [ToDo]
    
    @State private var isAlertShowing = false
    @State private var toDoTitle = ""
    @State private var toDoSubTitle = ""
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(
                    toDos){
                        toDo in
                        HStack{
                            Button{toDo.isCompleted.toggle()} label: {
                                Image(systemName:toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            Text(toDo.title)
                            Text(toDo.subTitle)
                        }
                    }
                    .onDelete(perform: deleteToDos)
            }
            .navigationTitle("ToDo App")
            .toolbar{
                Button{isAlertShowing.toggle()} label: {
                   Image(systemName: "plus.circle")
                }
            }
            .alert("Add ToDo", isPresented: $isAlertShowing){
                TextField("Enter ToDo", text: $toDoTitle)
                TextField("Enter SubTitle", text: $toDoSubTitle)
                
                Button {modelContext.insert(ToDo(title: toDoTitle, subTitle: toDoSubTitle, isCompleted: false))
                toDoTitle = ""} label: {
                    Text("Add")
                }
            }
            .overlay{
                if toDos.isEmpty {ContentUnavailableView("Nothing to do here", systemImage:  "checkmark.circle.fill")}
            }
        }
    }
    
    func deleteToDos(_ indexSet: IndexSet){
        for index in indexSet{
            let toDo = toDos[index]
            modelContext.delete(toDo)
        }
    }
}

#Preview {
    ContentView()
}
