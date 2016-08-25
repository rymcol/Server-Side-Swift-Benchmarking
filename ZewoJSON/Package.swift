import PackageDescription

let package = Package(
    name: "ZewoPress",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Zewo.git", majorVersion: 0, minor: 7),
        .Package(url: "https://github.com/Zewo/JSON.git", versions: Version(0,0,0)..<Version(10,0,0)),
    ]
)
