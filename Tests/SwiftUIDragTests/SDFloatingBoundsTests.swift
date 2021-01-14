//
//  SDFloatingBoundsTest.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag

/// SDFloatingBounds tests suite.
final class SDFloatingBoundsTests: XCTestCase {
    /// Tests content's validity of floating *only* on the `topLeading` side of the screen.
    func testSDFloatingBoundsTopLeading() {
        let floatingBounds = SDGeometryEngine.SDFloatingBounds.test(.topLeading)
        
        XCTAssertEqual(floatingBounds.state, .topLeading)
        XCTAssertNotEqual(floatingBounds.state, .topTrailing)
        XCTAssertNotEqual(floatingBounds.state, .bottomLeading)
        XCTAssertNotEqual(floatingBounds.state, .bottomTrailing)
    }
    
    /// Tests content's validity of floating *only* on the `topTrailing` side of the screen.
    func testSDFloatingBoundsTopTrailing() {
        let floatingBounds = SDGeometryEngine.SDFloatingBounds.test(.topTrailing)
        
        XCTAssertEqual(floatingBounds.state, .topTrailing)
        XCTAssertNotEqual(floatingBounds.state, .topLeading)
        XCTAssertNotEqual(floatingBounds.state, .bottomLeading)
        XCTAssertNotEqual(floatingBounds.state, .bottomTrailing)
    }
    
    /// Tests content's validity of floating *only* on the `bottomLeading` side of the screen.
    func testSDFloatingBoundsBottomLeading() {
        let floatingBounds = SDGeometryEngine.SDFloatingBounds.test(.bottomLeading)
        
        XCTAssertEqual(floatingBounds.state, .bottomLeading)
        XCTAssertNotEqual(floatingBounds.state, .topTrailing)
        XCTAssertNotEqual(floatingBounds.state, .topLeading)
        XCTAssertNotEqual(floatingBounds.state, .bottomTrailing)
    }
    
    /// Tests content's validity of floating *only* on the `bottomTrailing` side of the screen.
    func testSDFloatingBoundsBottomTrailing() {
        let floatingBounds = SDGeometryEngine.SDFloatingBounds.test(.bottomTrailing)
        
        XCTAssertEqual(floatingBounds.state, .bottomTrailing)
        XCTAssertNotEqual(floatingBounds.state, .topTrailing)
        XCTAssertNotEqual(floatingBounds.state, .bottomLeading)
        XCTAssertNotEqual(floatingBounds.state, .topLeading)
    }

    /// All tests conducted for SDFloatingBounds.
    static var allTests = [
        ("testSDFloatingBoundsTopLeading", testSDFloatingBoundsTopLeading),
        ("testSDFloatingBoundsTopTrailing", testSDFloatingBoundsTopTrailing),
        ("testSDFloatingBoundsBottomLeading", testSDFloatingBoundsBottomLeading),
        ("testSDFloatingBoundsBottomTrailing", testSDFloatingBoundsBottomTrailing),
    ]
}
