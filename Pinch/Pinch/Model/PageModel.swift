//
//  PageModel.swift
//  Pinch
//
//  Created by Rudy Pangestu on 5/20/25.
//

import Foundation

struct Page: Identifiable {
  let id: Int
  let imageName: String
}

extension Page {
  var thumbnailName: String {
    return "thumb-\(self.imageName)"
  }
}
