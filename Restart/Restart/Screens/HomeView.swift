//
//  HomeView.swift
//  Restart
//
//  Created by Rudy Pangestu on 5/16/25.
//

import SwiftUI

struct HomeView: View {
  // not initialize a new key value storage,
  @AppStorage("onboarding") var isOnboardingViewActive = false
  @State private var isAnimating: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      // MARK: - HEADER
      Spacer()
      
      ZStack {
        CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
        
        Image("character-2")
          .resizable()
          .scaledToFit()
          .padding()
          .offset(y: isAnimating ? 35 : -35)
          .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
      }
      
      // MARK: - CENTER
      Text("The time that leads to mastery is dependent on the intensity of our focus.")
        .font(.title3)
        .fontWeight(.light)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding()
      
      // MARK: - FOOTER
      Spacer()
      
      Button {
        playSound(sound: "success", type: "m4a")
        isOnboardingViewActive = true
      } label: {
        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
          .font(.system(size: 25, weight: .ultraLight))
          .imageScale(.large)
          .rotationEffect(.degrees(isAnimating ? 180 : 0))
          .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
        
        Text("Restart")
          .font(.system(.title2, design: .rounded))
          .fontWeight(.bold)
      }
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
      .padding(.bottom, 20)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        isAnimating = true
      })
    }
  }
}

#Preview {
  HomeView()
}
