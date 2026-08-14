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
            url: "https://api.github.com/repos/fraudcom/mobile/releases/assets/514147735.zip",
            checksum: "c389027557e44bc34b843ab8893469f2ab43345323344dff5c6c5527c526331d"
        )
    ]
)
