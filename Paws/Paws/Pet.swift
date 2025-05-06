//
//  Pet.swift
//  Paws
//
//  Created by Rudy Pangestu on 4/24/25.
//

import Foundation
import SwiftData

@Model
final class Pet {
  var name: String
  @Attribute(.externalStorage) var photo: Data?
  
  init(name: String, photo: Data? = nil) {
    self.name = name
    self.photo = photo
  }
}

extension Pet {
  @MainActor
  static var preview: ModelContainer {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Pet.self, configurations: configuration)
    
    container.mainContext.insert(Pet(name: "Choki"))
    container.mainContext.insert(Pet(name: "Bulbul"))
    
    return container
  }
}
