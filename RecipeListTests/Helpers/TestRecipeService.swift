//
//  TestRecipeService.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/29/25.
//

@testable import RecipeList

struct TestRecipeService: RecipeServiceProtocol {
  enum Result {
    case malformed, empty
    
    var fileName: String {
      switch self {
      case .malformed: return "MalformedRecipes"
      case .empty: return "EmptyRecipes"
      }
    }
  }
  
  let result: Result
  
  func getRecipes() async throws -> [Recipe] {
    let fileReader = FileReader(fileName: result.fileName, fileType: "json")
    let recipeList: RecipeList = try fileReader.getData()
    return recipeList.recipes
  }
}
