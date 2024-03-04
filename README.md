# GlassEffect

You can use this effect to produce a glass-like effect on top of your SwiftUI `View`s 🔍.

It models refraction and reflection of light taking the fresnel effect into account. It also allows one to calculate a "detail" that serves as a visual clue about the shape of the glass.

![output](https://github.com/Czajnikowski/GlassEffect/assets/973682/1a8ab0eb-736e-41d3-929b-74730fa9864a)

Be sure to check it in both light and dark mode (especially if you're after reflections ✨).

## How To Use It?

Use as a Swift Package.

Use a [`View.glassEffect` modifier](https://github.com/Czajnikowski/GlassEffect/blob/main/Sources/GlassEffect/GlassEffect.swift#L5-L24). At a minimum, you should be able to run the effect by supplying a normal map texture image. For best results, be sure to use high-quality normal maps.

## Credits

I used a bunch of resources from [3dtextures.me](https://3dtextures.me) and [everytexture.com](https://everytexture.com/) in the example app.

## Why?

I made it mostly for myself as an exercise in my recent `SwiftUI` + `Metal` research.

Feel free to use it, feel free to contribute (fix issues, share ideas), and feel free to hit me up [@czajnikowski](https://twitter.com/czajnikowski) 👋
