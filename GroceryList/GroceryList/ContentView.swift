//
//  ContentView.swift
//  GroceryList
//
//  Created by Rudy Pangestu on 4/21/25.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  @State private var item: String = ""
  @FocusState private var isFocused: Bool
  
  let buttonTip = ButtonTip()
  
  func setupTips() {
    do {
      try Tips.resetDatastore()
      Tips.showAllTipsForTesting()
      try Tips.configure([.displayFrequency(.immediate)])
    } catch {
      print("Error initializing TipKit \(error.localizedDescription)")
    }
  }
  
  init() {
    setupTips()
  }
  
  func addEssentialFoods() {
    [
      Item(title: "Anabul", isCompleted: false),
      Item(title: "Gundam", isCompleted: false),
      Item(title: "Tamiya", isCompleted: true),
      Item(title: "Crush gear", isCompleted: false)
    ].forEach({ item in
      modelContext.insert(item)
    })
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(items) { item in
          Text(item.title)
            .font(.title.weight(.light))
            .padding(.vertical, 2)
            .foregroundStyle(item.isCompleted ? Color.accentColor : Color.primary)
            .strikethrough(item.isCompleted)
            .italic(item.isCompleted)
            .swipeActions {
              Button(role: .destructive) {
                withAnimation {
                  modelContext.delete(item)
                }
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
            .swipeActions(edge: .leading) {
              Button("Done", systemImage: item.isCompleted ? "x.circle" : "checkmark.circle") {
                item.isCompleted.toggle()
              }
              .tint(item.isCompleted  ? .green : .accentColor)
            }
        }
      }
      .navigationTitle("Grocery List")
      .toolbar {
        if items.isEmpty {
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              addEssentialFoods()
            } label: {
              Image(systemName: "carrot")
            }
            .popoverTip(buttonTip)
          }
        }
      }
      .overlay {
        if items.isEmpty {
          ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
        }
      }
      .safeAreaInset(edge: .bottom, content: {
        VStack {
          TextField("", text: $item)
            .textFieldStyle(.plain)
            .padding(12)
            .background(.tertiary)
            .cornerRadius(12)
            .font(.title.weight(.light))
            .focused($isFocused)
          
          Button {
            guard !item.isEmpty else {
              return
            }
            
            let newItem = Item(title: item, isCompleted: false)
            modelContext.insert(newItem)
            item = ""
            isFocused = false
          } label: {
            Text("Save")
              .font(.title2.weight(.medium))
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
          .buttonBorderShape(.roundedRectangle)
          .controlSize(.extraLarge)
        }
        .padding()
        .background(.bar)
      })
    }
  }
}

#Preview("Sample Data") {
  let items: [Item] = [
    Item(title: "Anabul", isCompleted: false),
    Item(title: "Gundam", isCompleted: false),
    Item(title: "Tamiya", isCompleted: true),
    Item(title: "Crush gear", isCompleted: false),
    Item(title: "Crush gear2", isCompleted: false)
  ]
  
  let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
  
  for item in items {
    container.mainContext.insert(item)
  }
  
  return ContentView()
    .modelContainer(container)
}

#Preview("Empty List") {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
