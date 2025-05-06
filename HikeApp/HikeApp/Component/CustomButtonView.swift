//
//  CustomButtonView.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct CustomButtonView: View {
  private let grayLightToMediumGradient = LinearGradient(
    colors: [
      .customGrayLight,
      .customGrayMedium
    ],
    startPoint: .top,
    endPoint: .bottom
  )
  
  var body: some View {
    ZStack {
      Circle()
        .fill(
          LinearGradient(
            colors: [
              .white,
              .customGreenLight,
              .customGreenMedium
            ],
            startPoint: .top,
            endPoint: .bottom
          )
        )
      
      Circle()
        .stroke(grayLightToMediumGradient,lineWidth: 4)
      
      Image(systemName: "figure.hiking")
        .fontWeight(.black)
        .font(.system(size: 30))
        .foregroundStyle(grayLightToMediumGradient)
    }
    .frame(width: 58, height: 58)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  CustomButtonView()
    .padding()
}
