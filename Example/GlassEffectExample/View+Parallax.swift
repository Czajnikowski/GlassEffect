//
//  View+Parallax.swift
//  GlassEffectExample
//
//  Created by Maciek Czarnik on 01/03/2024.
//

import SwiftUI
import CoreMotion

#if os(iOS)
extension View {
  func withParallaxOffset(magnitude: Float) -> some View {
    modifier(ParallaxMotionModifier(magnitude: magnitude))
  }
}

private struct ParallaxMotionModifier: ViewModifier {
  @State private var pitch: Float = 0
  @State private var roll: Float = 0
  
  @StateObject var manager: MotionManager = MotionManager()
  
  var magnitude: Float
  
  func body(content: Content) -> some View {
    content
      .offset(
        x: CGFloat(roll * magnitude),
        y: CGFloat(-pitch * magnitude)
      )
      .onAppear {
        manager.setBindings(pitch: $pitch, roll: $roll)
        manager.initialize()
      }
  }
}

private class MotionManager: ObservableObject {
  @Binding var pitch: Float
  @Binding var roll: Float
  
  init() {
    _pitch = .constant(0)
    _roll = .constant(0)
  }
  
  func setBindings(pitch: Binding<Float>, roll: Binding<Float>) {
    _pitch = pitch
    _roll = roll
  }
  
  private let manager: CMMotionManager = CMMotionManager()
  
  func initialize() {
    self.manager.deviceMotionUpdateInterval = 1/60
    self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
      guard error == nil else {
        print(error!)
        return
      }
      
      if let motionData = motionData {
        self.pitch = Float(motionData.attitude.pitch)
        self.roll = Float(motionData.attitude.roll)
      }
    }
  }
}
#endif
