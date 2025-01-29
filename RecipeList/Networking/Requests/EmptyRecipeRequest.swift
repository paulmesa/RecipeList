//
//  EmptyRecipeRequest.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

struct EmptyRecipeRequest: BaseRequest {
  let domain: Domain = .cloudfront
  let path = "recipes-empty.json"
}
