import XCTest
@testable import KituraPress

class KituraPressTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(KituraPress().text, "Hello, World!")
    }


    static var allTests : [(String, (KituraPressTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
