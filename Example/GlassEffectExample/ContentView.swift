//
//  ContentView.swift
//  GlassEffectExample
//
//  Created by Maciek Czarnik on 28/02/2024.
//

import SwiftUI
import GlassEffect

struct ContentView: View {
  private var normalMapNames = ["90s", "Broken", "Blurred"]
  @State private var selectedNormalMapName = "90s"
  private var normalImageResource: ImageResource {
    .init(name: selectedNormalMapName + "Normal", bundle: .main)
  }
  
  @State private var distance: Float = 200
  @State private var transparency: Float = 0.85
  @State private var reflection: Float = 0.75
  @State private var detail: Float = 0.5
  @State private var lightPosition: CGPoint = .init(x: 0.1, y: 0.5)
  
  @State private var isConfigurationPresented = false
  
  var body: some View {
    Rectangle()
      .fill(.background.opacity(0.001))
      .background {
        Text(
          """
          🥹
          🏙️
          ♥️
          """
        )
        .font(.system(size: 100))
#if os(iOS)
        .withParallaxOffset(magnitude: distance / 2)
#endif
      }
      .ignoresSafeArea()
      .glassEffect(
        normal: .init(normalImageResource),
        distance: distance,
        transparency: transparency,
        reflection: reflection,
        lightPosition: lightPosition,
        detail: detail
      )
      .padding(.all, -50)
#if os(iOS)
      .withParallaxOffset(magnitude: 10)
#endif
      .overlay(alignment: .top) {
        Picker("Select map:", selection: $selectedNormalMapName) {
          ForEach(normalMapNames, id: \.self) {
            Text($0)
          }
        }
        // A change to `selectedNormalMapName` does not get picked up as a change otherwise... SwiftUI issue 🐛
        .onChange(of: selectedNormalMapName) { transparency += 0.0001 }
      }
      .overlay(alignment: .bottomTrailing) {
        Button(
          action: { isConfigurationPresented.toggle() },
          label: {
            Image(systemName: "slider.horizontal.3")
              .padding()
          }
        )
      }
      .font(.largeTitle)
      .sheet(isPresented: $isConfigurationPresented) {
        HStack {
          VStack {
            Slider(value: $distance, in: 0 ... 600).withText("distance")
            Slider(value: $transparency, in: 0 ... 1).withText("transparency")
            Slider(value: $detail, in: 0 ... 2).withText("detail")
          }
          VStack {
            Slider(value: $reflection, in: 0 ... 5).withText("reflection")
            Slider(value: $lightPosition.x, in: -1 ... 1).withText("x")
            Slider(value: $lightPosition.y, in: -1 ... 1).withText("y")
          }
        }
        .presentationDetents([.fraction(0.3)])
      }
  }
}

#Preview {
  ContentView()
}
