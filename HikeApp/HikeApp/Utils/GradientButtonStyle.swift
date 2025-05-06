//
//  GradientButtonStyle.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct GradientButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .padding(.vertical)
      .padding(.horizontal, 30)
      .background(
        // Conditional Statement with Nil Coalescing
        // Condition ? A : B
        configuration.isPressed ?
        // A: when user pressed button
        LinearGradient(
          colors: [
            .customGrayMedium,
            .customGrayLight
          ],
          startPoint: .top,
          endPoint: .bottom
        )
        :
        // B: when the button is not pressed
        LinearGradient(
          colors: [
            .customGrayLight,
            .customGrayMedium
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .cornerRadius(40)
  }
}
