//
//  CardView.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct CardView: View {
  // Mark - Properties
  @State private var imageNumber = 1
  @State private var randomNumber = 1
  @State private var isShowingSheet = false
  
  // Mark - Functions
  func randomImage() {
    // recursive style
//    let prevImageNumber = imageNumber
//    randomNumber = Int.random(in: 1...5)
//    imageNumber = randomNumber
//    
//    if prevImageNumber == imageNumber {
//      randomImage()
//    }
    
    // repeat style
    repeat {
      randomNumber = Int.random(in: 1...5)
    } while randomNumber == imageNumber
  
    imageNumber = randomNumber
  }
  
  var body: some View {
    ZStack {
      CustomBackgroundView()
      
      VStack {
        // Mark - Header
        VStack(alignment: .leading) {
          HStack {
            Text("Hiking")
              .fontWeight(.black)
              .font(.system(size: 52))
              .foregroundStyle(
                LinearGradient(
                  colors: [
                    .customGrayLight,
                    .customGrayMedium
                  ],
                  startPoint: .top,
                  endPoint: .bottom
                )
              )
            
            Spacer()
            
            Button {
              isShowingSheet.toggle()
            } label: {
              CustomButtonView()
            }
            .sheet(isPresented: $isShowingSheet) {
              SettingsView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
            }
          }
          
          Text("Fun and enjoyable outdoor activity for friends and families")
            .multilineTextAlignment(.leading)
            .italic()
            .foregroundColor(.customGrayMedium)
        }
        .padding(.horizontal, 30)
        
        // Mark - Main Content
        
        ZStack {
          CustomCircleView()
          
          Image("image-\(imageNumber)")
            .resizable()
            .scaledToFit()
            .animation(
              .easeOut(duration: 1),
              value: imageNumber
            )
        }
        
        // Mark - Footer
        Button {
          // generate a random number
          print("the button was pressed")
          randomImage()
        } label: {
          Text("Explore More")
            .font(.title2)
            .fontWeight(.heavy)
            .foregroundStyle(
              LinearGradient(
                colors: [
                  .customGreenLight,
                  .customGreenMedium
                ],
                startPoint: .top,
                endPoint: .bottom
              )
            )
            .shadow(
              color: .black.opacity(0.25),
              radius: 0.25,
              x: 1,
              y: 2
            )
        }
        .buttonStyle(GradientButton())
      }
    } // Card
    .frame(width: 320, height: 570)
  }
}

#Preview {
  CardView()
}
