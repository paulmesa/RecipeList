//
//  Image+data.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import SwiftUI
import UIKit

extension Image {
  init?(data: Data) {
    guard let image = UIImage(data: data) else { return nil }
    self = Image(uiImage: image)
  }
}
