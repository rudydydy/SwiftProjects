//
//  GroceryListApp.swift
//  GroceryList
//
//  Created by Rudy Pangestu on 4/21/25.
//

import SwiftUI
import SwiftData

@main
struct GroceryListApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Item.self)
    }
  }
}
