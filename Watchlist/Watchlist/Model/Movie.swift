//
//  Movie.swift
//  Watchlist
//
//  Created by Rudy Pangestu on 5/15/25.
//

import Foundation
import SwiftData

@Model
class Movie {
  var title: String
  var genre: Genre
  
  init(title: String, genre: Genre) {
    self.title = title
    self.genre = genre
  }
}

extension Movie  {
  @MainActor
  static var preview: ModelContainer {
    let container = try! ModelContainer(for: Movie.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Movie(title: "John Wick", genre: .action))
    container.mainContext.insert(Movie(title: "Toy Story", genre: .kids))
    
    return container
  }
}
