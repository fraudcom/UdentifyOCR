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
        .package(url: "https://github.com/fraudcom/UdentifyCommons.git", .exact("26.3.0928"))
    ],
    targets: [
        .binaryTarget(
            name: "UdentifyOCR",
            url: "https://api.github.com/repos/fraudcom/mobile/releases/assets/595145239.zip",
            checksum: "f4575f8db72ccb2ec8efd2ccf9c8a0571c7a5c1f2c26e65e111c7eeaca549c00"
        )
    ]
)
