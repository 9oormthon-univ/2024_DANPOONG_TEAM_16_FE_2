//
//  Button+.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct InsetRoundButton: ButtonStyle {
  var labelColor = Color.white
  var backgroundColor = Color.black
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(labelColor)
      .padding(.horizontal, 35)
      .padding(.vertical, 15)
      .background(Capsule().fill(backgroundColor))
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}
