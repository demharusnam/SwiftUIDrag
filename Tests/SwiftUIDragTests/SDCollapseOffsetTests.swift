//
//  SDCollapseOffsetTests.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag

/// SDCollapseOffset tests suite.
final class SDCollapseOffsetTests: XCTestCase {
    /// Tests initialization with the selected visible size.
    func testSDCollapseOffset() {
        let visibleSize = CGSize(width: 30, height: 15)
        let collapseOffset = SDGeometryEngine.CollapseOffset(distanceFrom: .test(), visibleSize: visibleSize)
        
        XCTAssertEqual(collapseOffset.toTop, -135)
        XCTAssertEqual(collapseOffset.toBottom, 85)
        XCTAssertEqual(collapseOffset.toLeading, -220)
        XCTAssertEqual(collapseOffset.toTrailing, 120)
    }
    
    /// All tests conducted for SDCollapseOffset.
    static var allTests = [
        ("testSDCollapseOffset", testSDCollapseOffset),
    ]
}
