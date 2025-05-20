//
//  ContentView.swift
//  Pinch
//
//  Created by Rudy Pangestu on 5/20/25.
//

import SwiftUI

struct ContentView: View {
  
  @State private var isAnimating: Bool = false
  @State private var imageScale: CGFloat = 1.0
  @State private var imageOffset: CGSize = .zero
  @State private var isDrawerOpen: Bool = false
  @State private var pageIndex: Int = 0
  
  let pages: [Page] = pagesData
  
  func resetImageState() {
    return withAnimation(.spring()) {
      imageScale = 1.0
      imageOffset = .zero
    }
  }
  
  func currentPage() -> String {
    return pages[pageIndex].imageName
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.clear
        
        Image(currentPage())
          .resizable()
          .scaledToFit()
          .cornerRadius(10)
          .padding()
          .shadow(color: .black.opacity(0.2), radius: 12, x: 2 , y: 2)
          .opacity(isAnimating ? 1 : 0)
          .animation(.linear(duration: 1), value: isAnimating)
          .offset(imageOffset)
          .scaleEffect(imageScale)
          .onTapGesture(count: 2) {
            withAnimation(.spring()) {
              imageScale = imageScale == 1 ? 5 : 1
            }
          }
          .gesture(
            DragGesture()
              .onChanged({ value in
                withAnimation(.linear(duration: 1)) {
                  imageOffset = value.translation
                }
              })
              .onEnded({ _ in
                if imageScale <= 1 {
                  resetImageState()
                }
              })
          )
          .gesture(
            MagnificationGesture()
              .onChanged({ value in
                withAnimation(.linear(duration: 1)) {
                  if imageScale >= 1 && imageScale <= 5 {
                    imageScale = value
                  } else if imageScale > 5 {
                    imageScale = 5
                  }
                }
              })
              .onEnded({ _ in
                if imageScale > 5 {
                  imageScale = 5
                } else if imageScale <= 1 {
                  resetImageState()
                }
              })
          )
      }
      .navigationTitle("Pinch & Zoom")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        isAnimating = true
      }
      .overlay(alignment: .top) {
        InfoPanelView(scale: imageScale, offset: imageOffset)
          .padding(.horizontal)
          .padding(.top, 30)
      }
      .overlay(alignment: .bottom) {
        Group {
          HStack {
            Button {
              withAnimation(.spring()) {
                if imageScale > 1 {
                  imageScale -= 1
                  
                  if imageScale <= 1 {
                    resetImageState()
                  }
                }
              }
            } label: {
              ControlImageView(imageIcon: "minus.magnifyingglass")
            }
            
            Button {
              resetImageState()
            } label: {
              ControlImageView(imageIcon: "arrow.up.left.and.down.right.magnifyingglass")
            }
            
            Button {
              withAnimation(.spring()) {
                if imageScale < 5 {
                  imageScale += 1
                  
                  if imageScale > 5 {
                    imageScale = 5
                  }
                }
              }
            } label: {
              ControlImageView(imageIcon: "plus.magnifyingglass")
            }
          }
          .padding(.vertical, 12)
          .padding(.horizontal, 20)
          .background(.ultraThinMaterial)
          .cornerRadius(12)
          .opacity(isAnimating ? 1 : 0)
        }
        .padding(.bottom, 30)
      }
      .overlay(alignment: .topTrailing) {
        HStack(spacing: 12) {
          Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
            .resizable()
            .scaledToFit()
            .frame(height: 40)
            .padding(8)
            .foregroundStyle(.secondary)
            .onTapGesture {
              withAnimation(.easeOut) {
                isDrawerOpen.toggle()
              }
            }
          
          ForEach(pages) { page in
            Image(page.thumbnailName)
              .resizable()
              .scaledToFit()
              .frame(width: 80)
              .cornerRadius(8)
              .shadow(radius: 4)
              .opacity(isDrawerOpen ? 1 : 0)
              .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
              .onTapGesture {
                withAnimation(.linear) {
                  isAnimating = true
                  pageIndex = page.id
                }
              }
          }
          
          Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .opacity(isAnimating ? 1 : 0)
        .frame(width: 260)
        .padding(.top, UIScreen.main.bounds.height / 12)
        .offset(x: isDrawerOpen ? 20 : 215)
      }
    }
    .navigationViewStyle(.stack)
  }
}

#Preview {
  ContentView()
}
