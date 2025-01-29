//
//  ImageService.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import Foundation

protocol ImageServiceProtocol {
  func getImageData(url: URL) async throws -> Data?
}

struct ImageService: ImageServiceProtocol {
  func getImageData(url: URL) async throws -> Data? {
    return try await URLSession.shared.data(from: url).0
  }
}
