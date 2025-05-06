//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Rudy Pangestu on 4/20/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Wish.self)
    }
  }
}
