//
//  NewMovieForm.swift
//  Watchlist
//
//  Created by Rudy Pangestu on 5/15/25.
//

import SwiftUI
import SwiftData

struct NewMovieFormView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  
  @State private var title: String = ""
  @State private var genre: Genre = .kids
  
  private func addNewMovie() {
    guard !title.isEmpty || !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      return
    }
    
    let movie  = Movie(title: title, genre: genre)
    modelContext.insert(movie)
    title = ""
    genre = .kids
    dismiss()
  }
  
  var body: some View {
    Form {
      List {
        Text("What to Watch")
          .font(.largeTitle.weight(.black))
          .foregroundStyle(.blue.gradient)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        
        TextField("Movie Title", text: $title)
          .textFieldStyle(.roundedBorder)
          .font(.largeTitle.weight(.light))
        
        Picker("Genre", selection: $genre) {
          ForEach(Genre.allCases) { genre in
            Text(genre.name)
              .tag(genre)
          }
        }
        
        Button {
          addNewMovie()
        } label: {
          Text("Save")
            .font(.title2.weight(.medium))
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.extraLarge)
        .buttonBorderShape(.roundedRectangle)
        .disabled(title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        
        Button {
          dismiss()
        } label: {
          Text("Close")
            .frame(maxWidth: .infinity)
        }
      }
      .listRowSeparator(.hidden)
    }
  }
}

#Preview {
  NewMovieFormView()
}
