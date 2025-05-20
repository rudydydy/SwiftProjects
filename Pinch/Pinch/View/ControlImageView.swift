//
//  ControlImageView.swift
//  Pinch
//
//  Created by Rudy Pangestu on 5/20/25.
//

import SwiftUI

struct ControlImageView: View {
  let imageIcon: String
  
  var body: some View {
    Image(systemName: imageIcon)
      .font(.system(size: 36))
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ControlImageView(imageIcon: "minus.magnifyingglass")
    .preferredColorScheme(.dark)
    .padding()
}
