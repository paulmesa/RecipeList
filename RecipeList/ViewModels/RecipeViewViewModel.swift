//
//  RecipeViewViewModel.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import SwiftUI

@MainActor
class RecipeViewViewModel: ObservableObject {
  let recipe: Recipe
  private let imageService: ImageServiceProtocol
  private let persistence: PersistenceProtocol?
  
  @Published var imageData: Data?
  @Published var isLoading: Bool = false
  
  init(recipe: Recipe, imageService: ImageServiceProtocol = ImageService(), persistence: PersistenceProtocol? = DiskPersistence(ttl: 60 * 60)) {
    self.recipe = recipe
    self.imageService = imageService
    self.persistence = persistence
  }
  
  func updateImageData() {
    guard !isLoading, let url = recipe.largePhotoUrl else { return }
    isLoading = true
    Task {
      do {
        var fromCache = false
        if let imageId = url.pathComponents.dropLast(1).last, let imageData = await persistence?.get(key: imageId)  {
          self.imageData = imageData
          fromCache = true
        }
        if !fromCache {
          imageData = try await imageService.getImageData(url: url)
          if let imageData, let imageId = url.pathComponents.dropLast(1).last {
            await persistence?.insert(key: imageId, data: imageData)
          }
        }
      } catch {
        print(error)
      }
      isLoading = false
    }
  }
}
