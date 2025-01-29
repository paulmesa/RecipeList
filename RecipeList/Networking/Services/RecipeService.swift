//
//  RecipeService.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

protocol RecipeServiceProtocol {
  func getRecipes() async throws -> [Recipe]
}

struct RecipeService: RecipeServiceProtocol {
  func getRecipes() async throws -> [Recipe] {
    let recipeList: RecipeList = try await RecipeRequest().getData()
    return recipeList.recipes
  }
}
