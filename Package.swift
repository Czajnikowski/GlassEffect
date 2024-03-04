// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GlassEffect",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  products: [
    .library(
      name: "GlassEffect",
      targets: ["GlassEffect"]
    ),
  ],
  targets: [
    .target(
      name: "GlassEffect",
      resources: [.process("Shaders/GlassEffect.metal")]
    ),
  ]
)
