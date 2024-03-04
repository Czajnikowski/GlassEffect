//
//  Slider+.swift
//  GlassEffectExample
//
//  Created by Maciek Czarnik on 01/03/2024.
//

import SwiftUI

extension Slider {
  func withText(_ text: String) -> some View {
    VStack {
      Text(text)
      self
    }
  }
}
