//
//  WatchlistApp.swift
//  Watchlist
//
//  Created by Rudy Pangestu on 5/15/25.
//

import SwiftUI
import SwiftData

@main
struct WatchlistApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Movie.self)
    }
  }
}
