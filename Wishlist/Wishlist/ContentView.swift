//
//  ContentView.swift
//  Wishlist
//
//  Created by Rudy Pangestu on 4/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var wishes: [Wish]
  
  @State private var isAlertShowing = false
  @State private var title = ""
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(wishes) { wish in
          Text(wish.title)
            .font(.title.weight(.light))
            .padding(.vertical, 2)
            .swipeActions {
              Button(role: .destructive) {
                modelContext.delete(wish)
              } label: {
                Image(systemName: "trash")
                  .foregroundColor(.red)
              }
            }
        }
      }
      .navigationTitle("Wishlist")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            isAlertShowing.toggle()
          } label: {
            Image(systemName: "plus")
              .imageScale(.large)
          }
        }
        
        if !wishes.isEmpty {
          ToolbarItem(placement: .bottomBar) {
            Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
          }
        }
      }
      .alert("Create a new wish", isPresented: $isAlertShowing, actions: {
        TextField("Enter a wish", text: $title)
        
        Button {
          modelContext.insert(Wish(title: title))
          title = ""
        } label: {
          Text("Save")
        }
      })
      .overlay {
        if wishes.isEmpty {
          ContentUnavailableView("My Wishlist", systemImage: "heart.circle", description: Text("No wishes yet. Add one to get started"))
        }
      }
    }
  }
}

#Preview("Empty List") {
  ContentView()
    .modelContainer(for: Wish.self, inMemory: true)
}

#Preview("List with Sample Data") {
  let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
  
  container.mainContext.insert(Wish(title: "Anabul Pomeranian"))
  container.mainContext.insert(Wish(title: "Second Pomeranian"))
  
  return ContentView()
    .modelContainer(container)
}
