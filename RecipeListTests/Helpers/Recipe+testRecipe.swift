//
//  Recipe+testRecipe.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/29/25.
//

import Foundation
@testable import RecipeList

extension Recipe {
  static var testRecipe: Recipe {
    return Recipe(cuisine: "Malaysian", name: "Apam Balik", id: .init(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!, largePhotoUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/test-test-test-test/large.jpg"), sourceUrl: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"), youtubeUrl: nil)  }
}
