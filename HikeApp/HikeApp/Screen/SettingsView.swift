//
//  SettingsView.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import SwiftUI

struct SettingsView: View {
  
  // Mark - Properties
  
  private let contentRows: [ContentRow] = [
    ContentRow(label: "Application", icon: "apps.iphone", content: "HIKE", color: .blue),
    ContentRow(label: "Compatability", icon: "info.circle", content: "iOS", color: .red),
    ContentRow(label: "Technology", icon: "swift", content: "Swift", color: .orange),
    ContentRow(label: "Version", icon: "gear", content: "1.0", color: .purple),
    ContentRow(label: "Developer", icon: "ellipsis.curlybraces", content: "Rudy", color: .mint),
    ContentRow(label: "Designer", icon: "paintpalette", content: "Bull", color: .pink),
  ]
  
  private let alernateAppIcons: [String] = [
    "AppIcon-MagnifyingGlass",
    "AppIcon-Map",
    "AppIcon-Mushroom",
    "AppIcon-Camera",
    "AppIcon-Backpack",
    "AppIcon-Campfire",
  ]
  
  var body: some View {
    List {
      // Mark - Header
      Section {
        HStack {
          Spacer()
          
          Image(systemName: "laurel.leading")
            .font(.system(size: 89, weight: .black))
          
          VStack(spacing: -10) {
            Text("Hike")
              .font(.system(size: 66, weight: .black))
            
            Text("Editor's Choice")
              .fontWeight(.medium)
          }
          
          Image(systemName: "laurel.trailing")
            .font(.system(size: 89, weight: .black))
          
          Spacer()
        }
        .foregroundStyle(
          LinearGradient(
            colors: [
              .customGreenLight,
              .customGreenMedium,
              .customGreenDark
            ],
            startPoint: .top,
            endPoint: .bottom)
        )
        .padding(.top, 8)
        
        VStack(spacing: 8) {
          Text("Where can you find \nperfect tracks?")
            .font(.title2)
            .fontWeight(.heavy)
          
          Text("The hike whcih looks gorgeus in photos but is even better once you are actually there. The hike that you hope to do again someday. \nFind the best day hikes in the app.")
            .font(.footnote)
            .italic()
          
          Text("Dust of the boots! It's time for a walk.")
            .fontWeight(.heavy)
            .foregroundColor(.customGreenMedium)
        }
        .multilineTextAlignment(.center)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity)
      }
      .listRowSeparator(.hidden)
      
      // Mark - Icons
      Section(header: Text("Alternate Icons")) {
        ScrollView(.horizontal, showsIndicators:  false) {
          LazyHStack(spacing: 12) {
            ForEach(alernateAppIcons.indices, id: \.self) { item in
              Button {
                print("pressed")
                UIApplication.shared.setAlternateIconName(alernateAppIcons [item]) { error in
                  if let error = error {
                    print("Failed to change icon \(String(describing: error.localizedDescription))")
                  }
                }
              } label: {
                Image("\(alernateAppIcons[item])-Preview")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 80, height: 80)
                  .cornerRadius(16)
              }
              .buttonStyle(.borderless)
            }
          }
        }
        .padding(.top, 12)
        
        Text("Choose your favorite app icon from the collection above.")
          .frame(minWidth: 0, maxWidth: .infinity)
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.footnote)
          .padding(.bottom, 12)
      }
      .listRowSeparator(.hidden)
      
      // Mark - About
      Section(
        header: Text("ABOUT THE APP"),
        footer: HStack {
          Spacer()
          Text("Copyright All right reserved.")
          Spacer()
        }
      ) {
        // 1. Basic Labeled Content
//        LabeledContent("Application", value: "Hike")
        
        // 2. Advance Labeled Content
//        LazyVStack {
//          ForEach(contentRows.indices, id: \.self) { i in
//            CustomListRowView(
//              rowLabel: contentRows[i].label,
//              rowIcon: contentRows[i].icon,
//              rowContent: contentRows[i].content,
//              rowTintColor: contentRows[i].color
//            )
//          }
//          
//          CustomListRowView(
//            rowLabel: "Website",
//            rowIcon: "globe",
//            rowTintColor: .indigo,
//            rowLinkLabel: "Credo Academy",
//            rowLinkDestination: "https://credo.academy"
//          )
//        }
        
        CustomListRowView(rowLabel: "Application", rowIcon: "apps.iphone", rowContent: "HIKE", rowTintColor: .blue)
        
        CustomListRowView(rowLabel: "Compatibility", rowIcon: "info.circle", rowContent: "iOS, iPadOS", rowTintColor: .red)
        
        CustomListRowView(rowLabel: "Technology", rowIcon: "swift", rowContent: "Swift", rowTintColor: .orange)
        
        CustomListRowView(rowLabel: "Version", rowIcon: "gear", rowContent: "1.0", rowTintColor: .purple)
        
        CustomListRowView(rowLabel: "Developer", rowIcon: "ellipsis.curlybraces", rowContent: "Rudy", rowTintColor: .mint)
        
        CustomListRowView(rowLabel: "Designer", rowIcon: "paintpalette", rowContent: "Robert Petras", rowTintColor: .pink)
        
        CustomListRowView(rowLabel: "Website", rowIcon: "globe", rowTintColor: .indigo, rowLinkLabel: "Credo Acedemy", rowLinkDestination: "https://credo.academy")
      }
    }
  }
}

#Preview {
  SettingsView()
}
