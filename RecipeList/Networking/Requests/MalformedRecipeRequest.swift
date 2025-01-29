//
//  MalformedRecipeRequest.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

struct MalformedRecipeRequest: BaseRequest {
  let domain: Domain = .cloudfront
  let path = "recipes-malformed.json"
}
