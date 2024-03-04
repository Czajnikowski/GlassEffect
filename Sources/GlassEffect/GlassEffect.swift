import SwiftUI

extension View {
  
  /// Applies a glass effect.
  ///
  /// - Parameters:
  ///   - normal: a normal map used to generate effect.
  ///   - distance: distance between the content (modified view) and the glass. The higher - the more refracted the output.
  ///   - color: glass color.
  ///   - transparency: 0.0 results in non-transparent glass of `color` color. 1.0 results in fully transparent glass.
  ///   - reflection: amount of reflections in the output
  ///   - lightPosition: the light, positioned at `lightPosition.x, lightPosition.y, -1` is used to provide the reflection on the glass.
  ///   - detail: corresponds to the amount of structural detail visible in the output.
  /// - Returns: A view with applied effect.
  public func glassEffect(
    normal: Image,
    distance: Float = 50,
    color: Color = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)),
    transparency: Float = 0.8,
    reflection: Float = 0.5,
    lightPosition: CGPoint = .init(x: 0.1, y: 0.5),
    detail: Float = 0.5
  ) -> some View {
    compositingGroup()
      .layerEffect(
        .init(
          function: .init(
            library: .bundle(.module),
            name: "glassEffect"
          ),
          arguments: [
            .image(normal),
            .float(distance),
            .color(color),
            .float(transparency),
            .float(reflection),
            .float2(lightPosition),
            .float(detail)
          ]
        ),
        maxSampleOffset: .zero
      )
  }
}
