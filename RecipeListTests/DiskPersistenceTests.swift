//
//  DiskPersistenceTests.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/29/25.
//

import XCTest
import Combine
@testable import RecipeList

@MainActor
final class DiskPersistenceTests: XCTestCase {
  func testInsertAndGet() async {
    let sut = DiskPersistence(ttl: 1)
    await sut.insert(key: "123", data: Data())
    
    let data = await sut.get(key: "123")
    XCTAssertNotNil(data)
  }
  
  func testInsertAndGetExpire() async {
    let sut = DiskPersistence(ttl: 0)
    await sut.insert(key: "123", data: Data())
    
    let data = await sut.get(key: "123")
    XCTAssertNil(data)
  }
}
