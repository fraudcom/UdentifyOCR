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
        .package(url: "https://github.com/fraudcom/UdentifyCommons.git", .exact("26.1.3"))
    ],
    targets: [
        .binaryTarget(
            name: "UdentifyOCR",
            url: "https://api.github.com/repos/fraudcom/mobile/releases/assets/397612105.zip",
            checksum: "8e060a475989ef4fae9ec7a4b5ce63992730eff5573116b2008286bc9a16304f"
        )
    ]
)
