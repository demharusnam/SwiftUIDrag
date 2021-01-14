//
//  SDDistanceTests.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag

/// SDDistance tests suite.
final class SDDistanceTests: XCTestCase {
    /// Tests initialization for SDDistance.
    func testSDDistance() {
        let distance: SDGeometryEngine.SDDistance = SDGeometryEngine.SDDistance.test()
        
        XCTAssertEqual(distance.toTop, -150)
        XCTAssertEqual(distance.toBottom, 100)
        XCTAssertEqual(distance.toLeading, -250)
        XCTAssertEqual(distance.toTrailing, 150)
    }
    
    /// All tests conducted for SDDistance.
    static var allTests = [
        ("testSDDistance", testSDDistance),
    ]
}
