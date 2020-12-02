import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Alamofire_RxTests.allTests),
    ]
}
#endif
