//
//  ContentView.swift
//  Paws
//
//  Created by Rudy Pangestu on 4/24/25.
//


import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query private var pets: [Pet]
  
  @State private var path = [Pet]()
  @State private var isEditing: Bool = false
  @State private var deleteConfirmationIsShowing: Bool = false
  @State private var petToDelete: Pet?
  
  let layout = [
    GridItem(.flexible(minimum: 150)),
    GridItem(.flexible(minimum: 150))
  ]
  
  func addPet() {
    isEditing = false
    let pet = Pet(name: "Best Friend")
    modelContext.insert(pet)
    path = [pet]
  }
  
  var body: some View {
    NavigationStack(path: $path) {
      ScrollView {
        LazyVGrid(columns: layout) {
          GridRow {
            ForEach(pets) { pet in
              NavigationLink(value: pet) {
                VStack {
                  if let imageData = pet.photo {
                    if let image = UIImage(data: imageData) {
                      Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minHeight: 0, maxHeight: 150)
                    }
                  } else {
                    Image(systemName: "pawprint.circle")
                      .resizable()
                      .scaledToFit()
                      .padding(40)
                      .foregroundStyle(.quaternary)
                  }
                  
                  Spacer()
                  
                  Text(pet.name)
                    .font(.title.weight(.light))
                    .padding(.vertical)
                  
                  Spacer()
                } //: VSTACK
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                .overlay(alignment: .topTrailing) {
                  if isEditing {
                    Button {
                      petToDelete = pet
                      deleteConfirmationIsShowing = true
                    } label: {
                      Image(systemName: "trash.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.purple)
                        .symbolRenderingMode(.multicolor)
                        .padding()
                    }
                    .confirmationDialog("Are you sure you want to delete \(petToDelete != nil ? petToDelete!.name : "")?", isPresented: $deleteConfirmationIsShowing, titleVisibility: .visible) {
                      Button("Delete", role: .destructive) {
                        if petToDelete != nil {
                          deleteConfirmationIsShowing = false
                          
                          withAnimation {
                            modelContext.delete(petToDelete!)
                            try? modelContext.save()
                            petToDelete = nil
                          }
                        }
                      }
                    }
                    
//                    Menu {
//                      Button("Delete \(pet.name)", systemImage: "trash", role: .destructive) {
//                        withAnimation {
//                          modelContext.delete(pet)
//                          try? modelContext.save()
//                        }
//                      }
//                    } label: {
//                      Image(systemName: "trash.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 36, height: 36)
//                        .foregroundStyle(.red)
//                        .symbolRenderingMode(.multicolor)
//                        .padding()
//                    }
                  }
                }
              } //: NAVLINK
              .foregroundStyle(.primary)
            } //: LOOP
          } //: GRID ROW
        } //: GRID LAYOUT
        .padding(.horizontal)
      } //: SCROLLVIEW
      .navigationTitle(pets.isEmpty ? "" : "Paws")
      .navigationDestination(for: Pet.self, destination: EditPetView.init)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            withAnimation {
              isEditing.toggle()
            }
          } label: {
            Image(systemName: "slider.horizontal.3")
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add a New Pet", systemImage: "plus.circle", action: addPet)
        }
      }
      .overlay {
        if pets.isEmpty {
          CustomContentUnavailableView(
            icon: "dog.circle",
            title: "No Pets",
            description: "Add a new pet to get started.")
        }
      }
    } //: NAVSTACK
  }
}

#Preview("Sample Data") {
  ContentView()
    .modelContainer(Pet.preview)
}

#Preview("No Data") {
  ContentView()
    .modelContainer(for: Pet.self, inMemory: true)
}
