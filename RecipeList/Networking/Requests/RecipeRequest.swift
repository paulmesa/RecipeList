//
//  RecipeRequest.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

struct RecipeRequest: BaseRequest {
  let domain: Domain = .cloudfront
  let path = "recipes.json"
}
