//
//  TestImageService.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/29/25.
//

import Foundation
import UIKit
@testable import RecipeList

struct TestImageService: ImageServiceProtocol {
  enum Result {
    case success, failure
  }
  let result: Result
  func getImageData(url: URL) async throws -> Data? {
    switch result {
    case .success: return UIImage(systemName: "carrot")?.pngData()
    case .failure: return nil
    }
  }
}
