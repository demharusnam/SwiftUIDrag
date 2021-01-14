//
//  SDFloatingBounds+Testable.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import SwiftUI
@testable import SwiftUIDrag

extension SDGeometryEngine.SDFloatingBounds {
    /**
     Accessory function to simplify testing for the four basic SDFloatingOptions: topLeading, topTrailing, bottomLeading, bottomLeading.
     
     - Parameters:
        - option: The *option* to be tested.
     
     - Returns: An instance of `SDFloatingBounds` to be tested based on the appropriate `option`.
     */
    static func test(_ option: SDFloatingOptions) -> SDGeometryEngine.SDFloatingBounds {
        let viewSize = CGSize(width: 300, height: 200)
        let floatingOptions: SDFloatingOptions = .all
        let collapseOptions: SDCollapseOptions = []
        var contentLocation: CGPoint {
            switch option {
            case .topLeading:
                return .init(x: 0, y: 0)
            case .topTrailing:
                return .init(x: 300, y: 0)
            case .bottomLeading:
                return .init(x: 0, y: 200)
            case .bottomTrailing:
                return .init(x: 300, y: 200)
            default:
                fatalError("Testing is only for the four basic SDFloatingOptions: topLeadin, topTrailing, bottomLeading, or bottomTrailing.")
            }
        }
        
        return SDGeometryEngine.SDFloatingBounds(viewSize: viewSize, contentLocation: contentLocation, floating: floatingOptions, collapse: collapseOptions)
    }
}
