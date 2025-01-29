//
//  RecipeListViewModel.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import SwiftUI

@MainActor
class RecipeListViewViewModel: ObservableObject {
  @Published var recipes: [Recipe]?
  @Published var isLoading: Bool = false

  private let recipeService: RecipeServiceProtocol

  init(recipeService: RecipeServiceProtocol = RecipeService()) {
    self.recipeService = recipeService
  }

  func updateRecipeList() {
    guard !isLoading else { return }
    Task {
      isLoading = true
      do {
        recipes = try await recipeService.getRecipes()
      } catch {
        recipes = []
        print(error)
      }
      isLoading = false
    }
  }
}
