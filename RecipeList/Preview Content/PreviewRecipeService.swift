//
//  PreviewRecipeService.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import Foundation

struct PreviewRecipeService: RecipeServiceProtocol {
  let loadTime: Int
  func getRecipes() async throws -> [Recipe] {
    let fileReader = FileReader(fileName: "PreviewRecipes", fileType: "json")
    // Gives illusion of loading to test load features
    try await Task.sleep(for: .seconds(loadTime))
    let recipeList: RecipeList = try fileReader.getData()
    return recipeList.recipes
  }
}
