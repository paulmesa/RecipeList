//
//  Recipe.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import Foundation

struct Recipe: Decodable, Identifiable, Equatable {
  let cuisine: String
  let name: String
  let id: UUID
  let largePhotoUrl: URL?
  let sourceUrl: URL?
  let youtubeUrl: URL?
  
  
  enum CodingKeys: String, CodingKey {
    case cuisine, name
    case id = "uuid"
    case largePhotoUrl = "photo_url_large"
    case sourceUrl = "source_url"
    case youtubeUrl = "youtube_url"
  }
}
