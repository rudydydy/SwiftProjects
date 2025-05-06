//
//  EditPetPreview.swift
//  Paws
//
//  Created by Rudy Pangestu on 4/24/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
  @Environment(\.dismiss) private var dismiss
  @Bindable var pet: Pet
  @State private var photosPickerItem: PhotosPickerItem?
  
  var buttonBack: some View {
    Button {
      dismiss()
    } label: {
      HStack {
        Image(systemName: "chevron.left")
          .aspectRatio(contentMode: .fit)
      }
    }
  }
  
  var body: some View {
    Form {
      if let imageData = pet.photo {
        if let image = UIImage(data: imageData) {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
            .padding(.top)
        }
      } else {
        CustomContentUnavailableView(icon: "pawprint.circle", title: "No Pets", description: "Add a photo of your favorite pet")
          .padding(.top)
      }
      
      PhotosPicker(selection: $photosPickerItem, matching: .images) {
        Label("Select a photo", systemImage: "photo.badge.plus")
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .listRowSeparator(.hidden)
      
      TextField("Name", text: $pet.name)
        .textFieldStyle(.roundedBorder)
        .font(.largeTitle.weight(.light))
        .padding(.vertical)
      
      Button {
        dismiss()
      } label: {
        Text("Save")
          .font(.title3.weight(.medium))
          .padding(8)
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .listRowSeparator(.hidden)
      .padding(.bottom)
    }
    .listStyle(.plain)
    .navigationTitle("Edit \(pet.name)")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .navigationBarItems(leading: buttonBack)
    .onChange(of: photosPickerItem) {
      Task {
        pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
      }
    }
  }
}

#Preview {
  NavigationStack {
    do {
      let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try! ModelContainer(for: Pet.self, configurations: configuration)
      
      return EditPetView(pet: Pet(name: "Bulbul"))
        .modelContainer(container)
    } catch {
      fatalError("Could not load preview data \(error.localizedDescription)")
    }
  }
}
