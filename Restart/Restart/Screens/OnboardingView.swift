//
//  OnboardingView.swift
//  Restart
//
//  Created by Rudy Pangestu on 5/16/25.
//

import SwiftUI

struct OnboardingView: View {
  
  // not initialize a new key value storage,
  // but True only will be set when key "onboarding" not found in device
  @AppStorage("onboarding") var isOnboardingViewActive = true
  
  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating: Bool = false
  @State private var imageOffset: CGSize = .init(width: 0, height: 0)
  @State private var indicatorOpacity: Double = 1.0
  @State private var textTitle: String = "Share."
  
  let hapticFeedback = UINotificationFeedbackGenerator()
  
  var body: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: - HEADER
        Spacer()
        
        VStack(spacing: 0) {
          Text(textTitle)
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .transition(.opacity)
            .id(textTitle) // make the Text view animatable
          
          Text("""
          It's not how much we give but
          how much love we put into giving.
          """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
        }
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
       
        // MARK: - CENTER
        ZStack {
          CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(.easeInOut(duration: 1), value: imageOffset)
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
            .offset(x: imageOffset.width * 1.2, y: 0)
            .rotationEffect(.degrees(Double(imageOffset.width / 20)))
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if abs(imageOffset.width) <= 150 {
                    imageOffset = gesture.translation
                    
                    withAnimation(.linear(duration: 0.25)) {
                      indicatorOpacity = 0
                      textTitle = "Give."
                    }
                  }
                }
                .onEnded { _ in
                  imageOffset = .zero
                  
                  withAnimation(.linear(duration: 0.25)) {
                    indicatorOpacity = 1
                    textTitle = "Share."
                  }
                }
            )
            .animation(.easeOut(duration: 1), value: imageOffset)
        }
        .overlay(
          Image(systemName: "arrow.left.and.right.circle")
            .font(.system(size: 44, weight: .ultraLight))
            .foregroundColor(.white)
            .offset(x: isAnimating ? -10 : 10)
//            .opacity(isAnimating ? 1 : 0)
            .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            .opacity(indicatorOpacity)
          , alignment: .bottom
        )
        
        Spacer()
        
        // MARK: - FOOTER
        ZStack {
          Capsule()
            .fill(.white.opacity(0.2))
          
          Capsule()
            .fill(.white.opacity(0.2))
            .padding(8)
          
          Text("Get Started")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .offset(x: 20)
          
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: buttonOffset + 80)
            
            Spacer()
          }
          
          HStack {
            ZStack {
              Circle()
                .fill(Color("ColorRed"))
              
              Circle()
                .fill(.black.opacity(0.15))
                .padding(8)
              
              Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                }
                .onEnded({ _ in
                  if buttonOffset < buttonWidth - 80 {
                    hapticFeedback.notificationOccurred(.warning)
                    withAnimation(.easeOut(duration: 0.5)) {
                      buttonOffset = 0
                    }
                  } else {
                    hapticFeedback.notificationOccurred(.success)
                    playSound(sound: "chimeup", type: "mp3")
                    isOnboardingViewActive = false
                  }
                })
            )
            Spacer()
          }
        }
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
      }
    }
    .onAppear {
      isAnimating = true
    }
    .preferredColorScheme(.dark)
  }
}

#Preview {
  OnboardingView()
}
