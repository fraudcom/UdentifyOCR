// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "UdentifyOCR",
    products: [
        .library(
            name: "UdentifyOCR",
            targets: ["UdentifyOCR"]),
    ],
    dependencies: [
        // Specify the dependency on `UdentifyCommons` with its repository URL and version or branch.
        .package(url: "https://github.com/fraudcom/UdentifyCommons.git", .exact("26.3.0814"))
    ],
    targets: [
        .binaryTarget(
            name: "UdentifyOCR",
            url: "https://api.github.com/repos/fraudcom/mobile/releases/assets/518017794.zip",
            checksum: "b82c0a76aa537f86b3fe94eeac1e6f1e24b1cf73a5287423fb4f4690ccb1cdfc"
        )
    ]
)
