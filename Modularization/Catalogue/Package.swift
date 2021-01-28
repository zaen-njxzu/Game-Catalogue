// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Catalogue",
  platforms: [.iOS(.v14)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Catalogue",
      targets: ["Catalogue"]),
  ],
  dependencies: [
    .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", .upToNextMajor(from: "5.4.4")),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
    .package(name: "CoreSDK", url: "https://github.com/zaen-njxzu/Game-Catalogue-CoreSDK.git", from: "2.2.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Catalogue",
      dependencies: [
        .product(name: "RealmSwift", package: "Realm"),
        "CoreSDK",
        "Alamofire"
      ]),
    .testTarget(
      name: "CatalogueTests",
      dependencies: ["Catalogue"]),
  ]
)
