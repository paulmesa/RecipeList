//
//  TestImagePersistence.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/29/25.
//

import Foundation
import XCTest
@testable import RecipeList

actor TestImagePersistence: PersistenceProtocol {
  let insertExpectation: XCTestExpectation?
  let getExpectation: XCTestExpectation?
  
  init(insertExpectation: XCTestExpectation?, getExpectation: XCTestExpectation?) {
    self.insertExpectation = insertExpectation
    self.getExpectation = getExpectation
  }
  var persistedKey: String? = nil
  var persistedData: Data? = nil
  
  func insert(key: String, data: Data) {
    persistedKey = key
    persistedData = data
    insertExpectation?.fulfill()
  }
  
  func get(key: String) -> Data? {
    guard let persistedKey, persistedKey == key, let persistedData else { return nil }
    getExpectation?.fulfill()
    return persistedData
  }
}
