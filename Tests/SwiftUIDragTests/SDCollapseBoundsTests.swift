//
//  SDCollapseBoundTest.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag

/// SDCollapseBounds tests suite.
final class SDCollapseBoundsTests: XCTestCase {
    /// Tests content's validity of collapsing *only* on the `top` side of the screen.
    func testSDCollapseBoundsTop() {
        let collapseBounds = SDGeometryEngine.SDCollapseBounds.test(.top)
        
        XCTAssertEqual(collapseBounds.state, .top)
        XCTAssertNotEqual(collapseBounds.state, .bottom)
        XCTAssertNotEqual(collapseBounds.state, .leading)
        XCTAssertNotEqual(collapseBounds.state, .trailing)
    }
    
    /// Tests content's validity of collapsing *only* on the `bottom` side of the screen.
    func testSDCollapseBoundsBottom() {
        let collapseBounds = SDGeometryEngine.SDCollapseBounds.test(.bottom)
        
        XCTAssertEqual(collapseBounds.state, .bottom)
        XCTAssertNotEqual(collapseBounds.state, .top)
        XCTAssertNotEqual(collapseBounds.state, .leading)
        XCTAssertNotEqual(collapseBounds.state, .trailing)
    }
    
    /// Tests content's validity of collapsing *only* on the `leading` side of the screen.
    func testSDCollapseBoundsLeading() {
        let collapseBounds = SDGeometryEngine.SDCollapseBounds.test(.leading)
        
        XCTAssertEqual(collapseBounds.state, .leading)
        XCTAssertNotEqual(collapseBounds.state, .top)
        XCTAssertNotEqual(collapseBounds.state, .bottom)
        XCTAssertNotEqual(collapseBounds.state, .trailing)
    }
    
    /// Tests content's validity of collapsing *only* on the `trailing` side of the screen.
    func testSDCollapseBoundsTrailing() {
        let collapseBounds = SDGeometryEngine.SDCollapseBounds.test(.trailing)
        
        XCTAssertEqual(collapseBounds.state, .trailing)
        XCTAssertNotEqual(collapseBounds.state, .top)
        XCTAssertNotEqual(collapseBounds.state, .leading)
        XCTAssertNotEqual(collapseBounds.state, .bottom)
    }

    /// All tests counducted for SDCollapseBounds.
    static var allTests = [
        ("testSDCollapseBoundsTop", testSDCollapseBoundsTop),
        ("testSDCollapseBoundsBottom", testSDCollapseBoundsBottom),
        ("testSDCollapseBoundsLeading", testSDCollapseBoundsLeading),
        ("testSDCollapseBoundsTrailing", testSDCollapseBoundsTrailing),
    ]
}
