//
//  Tip.swift
//  GroceryList
//
//  Created by Rudy Pangestu on 4/21/25.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
  var title: Text = Text("Essential Foods")
  var message: Text? = Text("Add some everyday items to the shopping list")
  var image: Image? = Image(systemName: "info.circle")
}
