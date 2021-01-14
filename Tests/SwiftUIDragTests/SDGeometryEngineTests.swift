//
//  File.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import XCTest
@testable import SwiftUIDrag
import SwiftUI

/// SDGeometryEngine tests suite.
final class SDGeometryEngineTests: XCTestCase {
    /// Size of content's parent view.
    private let container = CGSize(width: 300, height: 200)
    
    /// Rect of content to inherit SDView properties.
    private let content = CGRect(x: 150, y: 100, width: 100, height: 50)
        
    /// All supported alignments in SDView.
    private let alignments: [Alignment] = [
        .bottomLeading,
        .bottom,
        .bottomTrailing,
        .leading,
        .center,
        .trailing,
        .topLeading,
        .top,
        .topTrailing
    ]
    
    /// Tests location of content in SDView matches designation.
    func testLocation() {
        let expectedResults: [CGPoint] = [
            .init(x: 50, y: 175), // bottomLeading
            .init(x: 150, y: 175), // bottom
            .init(x: 250, y: 175), // bottomTrailing
            .init(x: 50, y: 100), // leading
            .init(x: 150, y: 100), // center
            .init(x: 250, y: 100), // trailing
            .init(x: 50, y: 25), // topLeading
            .init(x: 150, y: 25), // top
            .init(x: 250, y: 25), // topTrailing
        ]
        
        for i in 0...8 {
            let location: CGPoint = SDGeometryEngine.location(of: content, in: container, with: alignments[i])
            
            XCTAssertEqual(location, expectedResults[i], "Failed at index: \(i)")
        }
    }
    
    /// Tests updating of content location in SDView is done correctly.
    func testUpdate() {
        var contents: [CGRect] = Array(repeating: content, count: 9)
        let visibleSize = CGSize(width: 30, height: 15)
        let floatingOptions: SDFloatingOptions = .all
        let collapseOptions: SDCollapseOptions = .all
        var geometryEngine = SDGeometryEngine(
            for: contents[0], in: container,
            visibleSize: visibleSize,
            floatingOptions: floatingOptions,
            collapseOptions: collapseOptions
        )
        let expectedResults: [CGRect] = [
            .init(x: 0, y: 150, width: 100, height: 50), // bottomLeading
            .init(x: 100, y: 150, width: 100, height: 50), // bottom
            .init(x: 200, y: 150, width: 100, height: 50), // bottomTrailing
            .init(x: 0, y: 75, width: 100, height: 50), // leading
            .init(x: 100, y: 75, width: 100, height: 50), // center
            .init(x: 200, y: 75, width: 100, height: 50), // trailing
            .init(x: 0, y: 0, width: 100, height: 50), // topLeading
            .init(x: 100, y: 0, width: 100, height: 50), // top
            .init(x: 200, y: 0, width: 100, height: 50), // topTrailing
        ]

        for i in 0...8 {
            geometryEngine.update(rect: &contents[i], in: container, with: alignments[i])

            XCTAssertEqual(contents[i], expectedResults[i], "Failed at index: \(i)")
        }
    }
    
    /// All tests conducted for SDGeometryEngine.
    static var allTests = [
        ("testLocation", testLocation),
        ("testUpdate", testUpdate),
    ]
}
