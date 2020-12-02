import XCTest
@testable import Alamofire_Rx

final class Alamofire_RxTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Alamofire_Rx().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
