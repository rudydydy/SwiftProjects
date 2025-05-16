//
//  ContentView.swift
//  Restart
//
//  Created by Rudy Pangestu on 5/16/25.
//

import SwiftUI

struct ContentView: View {
  // Create a user default here,
  // key value storage for showing initial onboarding screen
  @AppStorage("onboarding") var isOnboardingViewActive = true
  
  var body: some View {
    ZStack {
      if isOnboardingViewActive {
        OnboardingView()
      } else {
        HomeView()
      }
    }
    .animation(.easeOut(duration: 0.5), value: isOnboardingViewActive)
  }
}

#Preview {
  ContentView()
}
