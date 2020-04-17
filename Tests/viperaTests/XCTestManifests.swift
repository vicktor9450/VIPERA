import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(viperaTests.allTests),
        testCase(ArgumentsReaderTest.allTests),
    ]
}
#endif
