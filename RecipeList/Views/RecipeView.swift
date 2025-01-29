//
//  RecipeView.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import SwiftUI

struct RecipeView: View {
  @StateObject var viewModel: RecipeViewViewModel
  
  init(recipe: Recipe) {
    _viewModel = StateObject(wrappedValue: RecipeViewViewModel(recipe: recipe))
  }
  var body: some View {
    VStack(spacing: 8) {
      if let data = viewModel.imageData, let image = Image(data: data) {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(16)
      } else {
        imagePlaceholder
      }

      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text(viewModel.recipe.name)
            .font(.headline)
          Text(viewModel.recipe.cuisine)
            .font(.subheadline)
        }
        
        Spacer()
        
        if let sourceUrl = viewModel.recipe.sourceUrl {
          Link("See full recipe", destination: sourceUrl)
            .font(.callout)
        } else if let youtubeUrl = viewModel.recipe.youtubeUrl {
          Link("See video", destination: youtubeUrl)
            .font(.callout)
        }
      }
    }
    .padding(.horizontal)
    .task {
      viewModel.updateImageData()
    }
  }
  
  private var imagePlaceholder: some View {
    ZStack {
      Color.green.opacity(0.5)
      if viewModel.isLoading {
        ProgressView()
      } else {
        Button(action: {
          viewModel.updateImageData()
        }) {
          VStack(spacing: 8) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
              .font(.system(size: 30))
            
            Text("Tap to retry loading image.")
            Spacer()
          }
          .foregroundStyle(Color.black)
          .frame(maxWidth: .infinity)
        }
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .cornerRadius(16)
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  RecipeView(recipe: .init(cuisine: "Malaysian", name: "Apam Balik", id: .init(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!, largePhotoUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"), sourceUrl: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"), youtubeUrl: nil))
  
  RecipeView(recipe: .init(cuisine: "Malaysian", name: "Apam Balik", id: .init(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!, largePhotoUrl: nil, sourceUrl: nil, youtubeUrl: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")))
}
