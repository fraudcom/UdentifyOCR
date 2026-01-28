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
        .package(url: "https://github.com/fraudcom/UdentifyCommons.git", .exact("25.4.0"))
    ],
    targets: [
        .binaryTarget(
            name: "UdentifyOCR",
            url: "https://api.github.com/repos/fraudcom/mobile/releases/assets/330210244.zip",
            checksum: "19b1d8cf032ac03e734acdacf4bfc5a673ec2333c6cebefd1c8b247cc4c69274"
        )
    ]
)
