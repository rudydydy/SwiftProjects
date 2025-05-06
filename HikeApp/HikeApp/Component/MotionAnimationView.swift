//
//  MotionAnimationView.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct MotionAnimationView: View {
  // Mark - Properties
  @State private var randomCircle = Int.random(in: 6...12)
  @State private var isAnimating = false
  
  // Mark - Functions
  // 1. Random Coordinate
  func randomCoordinate() -> CGFloat {
    return CGFloat.random(in: 0...256)
  }
  
  // 2. Random Size
  func randomSize() -> CGFloat {
    return CGFloat(Int.random(in: 4...80))
  }
  
  // 3. Random Scale
  func randomScale() -> CGFloat {
    return CGFloat(Double.random(in: 0.1...2.0))
  }
  
  // 4. Random Speed
  func randomSpeed() -> Double {
    return Double.random(in: 0.005...1.0)
  }
  
  // 5. Random Delay
  func randomDelay() -> Double {
    return Double.random(in: 0...2)
  }
  
  var body: some View {
    ZStack {
      ForEach(0...randomCircle, id: \.self) { item in
        Circle()
          .foregroundColor(.white)
          .opacity(0.25)
          .position(x: randomCoordinate(), y: randomCoordinate())
          .frame(width: randomSize())
          .scaleEffect(isAnimating ? randomScale() : 1)
          .onAppear(perform: {
            withAnimation(
              .interpolatingSpring(
                stiffness: 0.25,
                damping: 0.25
              )
              .repeatForever()
              .speed(randomSpeed())
              .delay(randomDelay())
            ) {
              isAnimating = true
            }
          })
      }
    }
    .frame(width: 256, height: 256)
    .mask(Circle())
    .drawingGroup() // <- high performance rendering
  }
}

#Preview {
  MotionAnimationView()
    .background {
      Circle()
        .fill(.teal)
    }
}
