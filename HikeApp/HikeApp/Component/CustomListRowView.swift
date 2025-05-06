//
//  CustomListRowView.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct CustomListRowView: View {
  // Mark - Properties
  @State var rowLabel: String
  @State var rowIcon: String
  @State var rowContent: String? = nil
  @State var rowTintColor: Color
  @State var rowLinkLabel: String? = nil
  @State var rowLinkDestination: String? = nil
  
  var body: some View {
    LabeledContent {
      // Content
      if let content = rowContent {
        Text(content)
          .foregroundColor(.primary)
          .fontWeight(.heavy)
      } else if (rowLinkLabel != nil && rowLinkDestination != nil) {
        Link(rowLinkLabel!, destination: URL(string: rowLinkDestination!)!)
          .foregroundColor(.pink)
          .fontWeight(.heavy)
          .buttonStyle(.plain)
      } else {
        EmptyView()
      }
    } label: {
      HStack {
        ZStack{
          RoundedRectangle(cornerRadius: 8)
            .frame(width: 30, height: 30)
            .foregroundColor(rowTintColor)
          
          Image(systemName: rowIcon)
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
        Text(rowLabel)
      }
    }
  }
}

#Preview {
  List() {
    CustomListRowView(
      rowLabel: "Designer",
      rowIcon: "paintpalette",
      rowContent: "John Doe",
      rowTintColor: .pink)
    .listRowSeparator(.hidden)
    
    CustomListRowView(
      rowLabel: "Website",
      rowIcon: "globe",
      rowTintColor: .blue,
      rowLinkLabel: "Credo Academy",
      rowLinkDestination: "https://credo.academy"
    )
  }
}
