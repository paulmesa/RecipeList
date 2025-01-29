//
//  RecipeListViewModelTests.swift
//  RecipeListTests
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import XCTest
import Combine
@testable import RecipeList

@MainActor
final class RecipeListViewModelTests: XCTestCase {
  private var cancellables = Set<AnyCancellable>()

  func testInit() throws {
    let sut = RecipeListViewViewModel(recipeService: PreviewRecipeService(loadTime: 0))
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.recipes)
  }

  func testUpdateRecipeListSuccess() async {
    let sut = RecipeListViewViewModel(recipeService: PreviewRecipeService(loadTime: 0))
    await setupTestWithSut(sut: sut)
    XCTAssertNotNil(sut.recipes)
    XCTAssertFalse((sut.recipes ?? []).isEmpty)
    XCTAssertFalse(sut.isLoading)
  }

  func testUpdateRecipeListEmpty() async {
    let sut = RecipeListViewViewModel(recipeService: TestRecipeService(result: .empty))
    await setupTestWithSut(sut: sut)
    XCTAssertNotNil(sut.recipes)
    XCTAssertTrue((sut.recipes ?? []).isEmpty)
    XCTAssertFalse(sut.isLoading)
  }

  func testUpdateRecipeListMalformed() async {
    let sut = RecipeListViewViewModel(recipeService: TestRecipeService(result: .malformed))
    await setupTestWithSut(sut: sut)
    XCTAssertNotNil(sut.recipes)
    XCTAssertTrue((sut.recipes ?? []).isEmpty)
    XCTAssertFalse(sut.isLoading)
  }

  private func setupTestWithSut(sut: RecipeListViewViewModel) async {
    let isLoadingExpectation = self.expectation(description: "isLoading should be true at some point")
    sut.$isLoading.sink { isLoading in
      guard isLoading else { return }
      isLoadingExpectation.fulfill()
    }.store(in: &cancellables)
    let recipesExpectation = self.expectation(description: "recipes should be updated")
    sut.$recipes.sink { recipes in
      guard recipes != nil else { return }
      recipesExpectation.fulfill()
    }.store(in: &cancellables)
    sut.updateRecipeList()
    await fulfillment(of: [isLoadingExpectation, recipesExpectation], timeout: 1)
  }
}
