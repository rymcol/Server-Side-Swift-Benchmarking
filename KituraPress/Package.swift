import PackageDescription

let package = Package(
    name: "KituraPress",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 27),
        .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", versions: Version(0,0,0)..<Version(50,0,0)),
    ],
    exclude: ["Makefile", "Kitura-Build"]
)
