import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDCollapseBoundsTests.allTests),
        testCase(SDFloatingBoundsTests.allTests),
        testCase(SDDistanceTests.allTests),
        testCase(SDCollapseOffsetTests.allTests),
        testCase(SDFloatingOffsetTests.allTests),
        testCase(SDGeometryEngineTests.allTests),
    ]
}
#endif
