//
//  RecipeViewViewModelTests.swift
//  RecipeListTests
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import XCTest
import Combine
@testable import RecipeList

@MainActor
final class RecipeViewViewModelTests: XCTestCase {
  private var cancellables = Set<AnyCancellable>()

  func testInit() throws {
    let sut = RecipeViewViewModel(recipe: .testRecipe, imageService: TestImageService(result: .success), persistence: nil)
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.imageData)
  }
  
  func testUpdateImageDataSuccess() async {
    let sut = RecipeViewViewModel(recipe: .testRecipe, imageService: TestImageService(result: .success), persistence: nil)
    let isLoadingExpectation = self.expectation(description: "isLoading should be true at some point")
    sut.$isLoading.sink { isLoading in
      guard isLoading else { return }
      isLoadingExpectation.fulfill()
    }.store(in: &cancellables)
    let imageDataExpectation = self.expectation(description: "image data should be updated")
    sut.$imageData.sink { data in
      guard data != nil else { return }
      imageDataExpectation.fulfill()
    }.store(in: &cancellables)
    
    sut.updateImageData()
    await fulfillment(of: [isLoadingExpectation, imageDataExpectation], timeout: 1)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNotNil(sut.imageData)
  }
  
  func testUpdateImageFailure() async {
    let sut = RecipeViewViewModel(recipe: .testRecipe, imageService: TestImageService(result: .failure), persistence: nil)
    let isLoadingExpectation = self.expectation(description: "isLoading should be true at some point")
    sut.$isLoading.sink { isLoading in
      guard isLoading else { return }
      isLoadingExpectation.fulfill()
    }.store(in: &cancellables)
    let imageDataExpectation = self.expectation(description: "image data should be updated")
    sut.$imageData.dropFirst().sink { data in
      guard data == nil else { return }
      imageDataExpectation.fulfill()
    }.store(in: &cancellables)
    
    sut.updateImageData()
    await fulfillment(of: [isLoadingExpectation, imageDataExpectation], timeout: 1)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.imageData)
  }

  func testUpdateImagePersistence() async {
    let insertExpectation = self.expectation(description: "Insert is called")
    let getExpectation = self.expectation(description: "Get is called")
    let imageService = TestImageService(result: .success)
    let persistence = TestImagePersistence(insertExpectation: insertExpectation, getExpectation: getExpectation)
    let sut = RecipeViewViewModel(recipe: .testRecipe, imageService: imageService, persistence: persistence)
    sut.updateImageData()
    await fulfillment(of: [insertExpectation], timeout: 1)
    sut.updateImageData()
    await fulfillment(of: [getExpectation], timeout: 1)
    XCTAssertNotNil(sut.imageData)
    
    let key = await persistence.persistedKey
    XCTAssertNotNil(key)
    XCTAssertEqual(key, "test-test-test-test")
    
    let data = await persistence.persistedData
    let resultData = try? await imageService.getImageData(url: URL(string: "https://test.com")!)
    XCTAssertNotNil(data)
    XCTAssertEqual(data, resultData)
  }

}
