//
//  RecipeList.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
  @StateObject var viewModel: RecipeListViewViewModel
  
  init(recipeService: RecipeServiceProtocol = RecipeService()) {
    _viewModel = StateObject(wrappedValue: RecipeListViewViewModel(recipeService: recipeService))
  }

  var body: some View {
    ScrollView {
      if viewModel.isLoading {
          ProgressView()
          .containerRelativeFrame([.horizontal, .vertical])
      } else if let recipes = viewModel.recipes {
        LazyVStack {
          if recipes.isEmpty {
            EmptyRecipeListView()
          } else {
            ForEach(recipes) { recipe in
              RecipeView(recipe: recipe)
                .padding(.bottom)
            }
          }
        }
      }
    }
    .refreshable {
      viewModel.updateRecipeList()
    }
    .task {
      viewModel.updateRecipeList()
    }
    .animation(.default, value: viewModel.isLoading)
    .animation(.default, value: viewModel.recipes)
  }
}

#Preview {
  RecipeListView(recipeService: PreviewRecipeService(loadTime: 2))
}


