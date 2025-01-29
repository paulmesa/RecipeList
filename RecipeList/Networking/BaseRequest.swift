//
//  BaseRequest.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import Foundation

protocol BaseRequest {
  var domain: Domain { get }
  var path: String { get }
  func getData<T: Decodable>() async throws -> T
}

extension BaseRequest {
  func getData<T: Decodable>() async throws -> T {
    guard let url = URL(string: domain.rawValue)?.appending(path: path) else {
      throw NetworkError.malformedUrl
    }
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
    return try JSONDecoder().decode(T.self, from: data)
  }
}
