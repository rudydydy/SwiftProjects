//
//  PawsApp.swift
//  Paws
//
//  Created by Rudy Pangestu on 4/24/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Pet.self)
    }
  }
}
