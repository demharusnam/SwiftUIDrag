//
//  SDFloatingOffsetTests.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag

/// SDFloatingOffset tests suite.
final class SDFloatingOffsetTests: XCTestCase {
    /// Tests initialization.
    func testSDFloatingOffset() {
        let floatingOffset = SDGeometryEngine.SDFloatingOffset(distanceFrom: .test())
        
        XCTAssertEqual(floatingOffset.toTop, -100)
        XCTAssertEqual(floatingOffset.toBottom, 50)
        XCTAssertEqual(floatingOffset.toLeading, -150)
        XCTAssertEqual(floatingOffset.toTrailing, 50)
    }
    
    /// All tests conducted for SDFloatingOffset.
    static var allTests = [
        ("testSDFloatingOffset", testSDFloatingOffset),
    ]
}
