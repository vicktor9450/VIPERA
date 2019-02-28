import XCTest

import viperaTests

var tests = [XCTestCaseEntry]()
tests += viperaTests.allTests()
XCTMain(tests)