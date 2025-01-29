//
//  EmptyRecipeListView.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/27/25.
//

import SwiftUI

struct EmptyRecipeListView: View {
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: "exclamationmark.triangle.fill")
        .font(.system(size: 30))
      
      Text("There are no recipes at this time.")
      
      Text("Swipe down to refresh.")
    }
    .containerRelativeFrame([.horizontal, .vertical])
  }
}

#Preview {
  EmptyRecipeListView()
}
