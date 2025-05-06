//
//  WishModel.swift
//  Wishlist
//
//  Created by Rudy Pangestu on 4/20/25.
//

import Foundation
import SwiftData

@Model
class Wish {
  var title: String
  
  init(title: String) {
    self.title = title
  }
}
