//
//  FileReader.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import Foundation

struct FileReader {

  enum ReaderError: Error {
    case notFound
    case noData
    case invalidUrl
  }

  private static let fileManager = FileManager()
  private let fileName: String
  private let fileType: String
  
  init(fileName: String, fileType: String) {
    self.fileName = fileName
    self.fileType = fileType
  }
  
  func getData<T: Decodable>() throws -> T {
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileType), Self.fileManager.fileExists(atPath: path), let url = URL(string: path) else {
      throw ReaderError.notFound
    }
    let fileHandle = try FileHandle(forReadingFrom: url)
    guard let data = try fileHandle.readToEnd() else {
      throw ReaderError.noData
    }
    return try JSONDecoder().decode(T.self, from: data)
  }
}
